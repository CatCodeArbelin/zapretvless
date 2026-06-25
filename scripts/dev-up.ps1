<#
.SYNOPSIS
    Restores, builds, tests, prepares local development folders, checks engines,
    optionally starts the Windows service in development mode, and launches the UI.

.NOTES
    This script intentionally does not enable DPI/VLESS, change DNS, change the
    system proxy, or start network interception automatically.
#>

[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Write-Section {
    param([Parameter(Mandatory = $true)][string]$Message)
    Write-Host "`n==> $Message" -ForegroundColor Cyan
}

function Write-WarningMessage {
    param([Parameter(Mandatory = $true)][string]$Message)
    Write-Warning $Message
}

if (-not [System.Runtime.InteropServices.RuntimeInformation]::IsOSPlatform([System.Runtime.InteropServices.OSPlatform]::Windows)) {
    Write-Error 'scripts/dev-up.ps1 must be run on Windows because it prepares Windows service and engine paths.'
    exit 1
}

$repoRoot = Split-Path -Parent $PSScriptRoot
Set-Location $repoRoot

Write-Section 'Checking prerequisites'
if (-not (Get-Command dotnet -ErrorAction SilentlyContinue)) {
    Write-Error 'The .NET SDK command "dotnet" was not found. Install the .NET SDK and ensure dotnet is on PATH.'
    exit 1
}
Write-Host 'dotnet is available.'

Write-Section 'Restoring, building, and testing'
dotnet restore
dotnet build
dotnet test

Write-Section 'Checking engine binaries'
$xrayPath = Join-Path $repoRoot 'engines/xray/xray.exe'
$zapretWinwsPath = Join-Path $repoRoot 'engines/zapret/winws.exe'
$zapretWinws2Path = Join-Path $repoRoot 'engines/zapret/winws2.exe'
$winDivertPath = Join-Path $repoRoot 'engines/zapret/WinDivert64.sys'

if (-not (Test-Path -LiteralPath $xrayPath -PathType Leaf)) {
    Write-WarningMessage "Missing xray engine binary: $xrayPath"
}

if (-not ((Test-Path -LiteralPath $zapretWinwsPath -PathType Leaf) -or (Test-Path -LiteralPath $zapretWinws2Path -PathType Leaf))) {
    Write-WarningMessage "Missing zapret engine binary: expected $zapretWinwsPath or $zapretWinws2Path"
}

if (-not (Test-Path -LiteralPath $winDivertPath -PathType Leaf)) {
    Write-WarningMessage "Missing WinDivert driver: $winDivertPath"
}

Write-Section 'Creating local application directories'
$localAppData = [Environment]::GetFolderPath('LocalApplicationData')
if ([string]::IsNullOrWhiteSpace($localAppData)) {
    Write-Error 'LOCALAPPDATA could not be resolved.'
    exit 1
}

$appRoot = Join-Path $localAppData 'ArbelinOne'
$logsDir = Join-Path $appRoot 'logs'
$configsDir = Join-Path $appRoot 'configs'
foreach ($dir in @($appRoot, $logsDir, $configsDir)) {
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
    Write-Host "Ensured directory: $dir"
}

Write-Section 'Checking Windows service'
$serviceCandidates = @(
    'ArbelinOne',
    'Arbelin.One',
    'Arbelin.One.Service',
    'ArbelinOneService'
)
$service = $null
foreach ($candidate in $serviceCandidates) {
    $service = Get-Service -Name $candidate -ErrorAction SilentlyContinue
    if ($null -ne $service) {
        break
    }
}

if ($null -eq $service) {
    Write-WarningMessage 'Windows Service is not installed.'
    Write-Host 'Install it with: .\scripts\install-service.ps1' -ForegroundColor Yellow
}
else {
    Write-Host "Found Windows Service: $($service.Name) ($($service.DisplayName))"
    if ($service.Status -eq 'Running') {
        Write-Host 'Service is already running.'
    }
    else {
        Write-Host 'Attempting to start the service in development mode. If unsupported, the script will not perform a normal service start.'
        $started = $false
        try {
            & sc.exe start $service.Name --dev | Write-Host
            Start-Sleep -Seconds 2
            $service.Refresh()
            $started = ($service.Status -eq 'Running')
        }
        catch {
            Write-WarningMessage "Development-mode service start failed: $($_.Exception.Message)"
        }

        if (-not $started) {
            Write-WarningMessage 'The service did not report Running after the development-mode start attempt. It may not support development-mode arguments; not starting it normally to avoid enabling interception automatically.'
        }
    }
}

Write-Section 'Safety notice'
Write-Host 'This script does not enable DPI/VLESS, change DNS, change the system proxy, or start network interception automatically.' -ForegroundColor Yellow

$clientProject = Join-Path $repoRoot 'src/Arbelin.One.Client'
Write-Section 'Starting UI'
dotnet run --project $clientProject
