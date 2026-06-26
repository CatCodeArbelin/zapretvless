<#
.SYNOPSIS
    Runs safe PR-01 bootstrap checks and then starts the client project.

.NOTES
    This script does not start Windows Service, Xray, Zapret, WinDivert,
    and does not change DNS, proxy, routes, or host networking.
#>

[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Write-Section {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Message
    )

    Write-Host "`n==> $Message" -ForegroundColor Cyan
}

function Invoke-Step {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Description,

        [Parameter(Mandatory = $true)]
        [scriptblock]$Command
    )

    Write-Section $Description
    & $Command

    if ($LASTEXITCODE -ne 0) {
        Write-Error "$Description failed with exit code $LASTEXITCODE."
        exit $LASTEXITCODE
    }
}

$repoRoot = Split-Path -Parent $PSScriptRoot
Set-Location $repoRoot

Write-Section 'Safety notice'
Write-Host 'Safe bootstrap only: restore, build, test, and run the client project.' -ForegroundColor Yellow
Write-Host 'No engines, Windows Service install/start, DNS, proxy, routes, or WinDivert actions are performed.' -ForegroundColor Yellow

Write-Section 'Checking prerequisites'
if (-not (Get-Command dotnet -ErrorAction SilentlyContinue)) {
    Write-Error 'The .NET SDK command "dotnet" was not found. Install the .NET SDK and ensure dotnet is on PATH.'
    exit 1
}

Invoke-Step 'Restoring solution' { dotnet restore .\zapretvless.sln }
Invoke-Step 'Building solution' { dotnet build .\zapretvless.sln --configuration Release }
Invoke-Step 'Testing solution' { dotnet test .\zapretvless.sln --configuration Release }
Invoke-Step 'Starting client project' { dotnet run --project .\src\Arbelin.One.Client\Arbelin.One.Client.csproj }
