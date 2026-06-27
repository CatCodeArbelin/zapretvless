param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$solutionPath = Join-Path $repoRoot 'zapretvless.sln'
$clientProject = Join-Path $repoRoot 'src/Arbelin.One.Client/Arbelin.One.Client.csproj'

if (-not $IsWindows) {
    throw 'dev-up.ps1 must be run on Windows because the client is a WPF application.'
}

if (-not (Get-Command dotnet -ErrorAction SilentlyContinue)) {
    throw 'dotnet SDK was not found. Install .NET 8 SDK first.'
}

if (-not (Test-Path $solutionPath)) {
    throw "Solution file not found: $solutionPath"
}

$localAppData = [Environment]::GetFolderPath('LocalApplicationData')
$appRoot = Join-Path $localAppData 'ArbelinOne'
$logsDir = Join-Path $appRoot 'logs'
$configsDir = Join-Path $appRoot 'configs'

New-Item -ItemType Directory -Force -Path $appRoot, $logsDir, $configsDir | Out-Null

Write-Host 'PR-01 bootstrap mode: Xray, Zapret, WinDivert, DNS, proxy and routes are not touched.'
Write-Host 'Running restore/build/test...'

dotnet restore $solutionPath
dotnet build $solutionPath --configuration Release
dotnet test $solutionPath --configuration Release

Write-Host 'Starting WPF client...'
dotnet run --project $clientProject
