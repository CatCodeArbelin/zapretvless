<#
.SYNOPSIS
    Safely runs local .NET validation checks without starting application runtime components.

.DESCRIPTION
    This script is intended for local development and CI-style validation only. It verifies
    that the .NET SDK is available, then runs dotnet restore, dotnet build, and dotnet test.

.NOTES
    Safety guarantees:
    - Does not start the UI.
    - Does not start or install any Windows Service.
    - Does not touch DNS, system proxy, WinDivert, zapret, xray, or any runtime behavior.
#>

[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Write-Section {
    param([Parameter(Mandatory = $true)][string]$Message)
    Write-Host "`n==> $Message" -ForegroundColor Cyan
}

function Invoke-Check {
    param(
        [Parameter(Mandatory = $true)][string]$Description,
        [Parameter(Mandatory = $true)][scriptblock]$Command
    )

    Write-Section $Description
    & $Command

    if ($LASTEXITCODE -ne 0) {
        Write-Error "$Description failed with exit code $LASTEXITCODE."
        exit $LASTEXITCODE
    }

    Write-Host "$Description completed successfully." -ForegroundColor Green
}

$repoRoot = Split-Path -Parent $PSScriptRoot
Set-Location $repoRoot

Write-Section 'Safety notice'
Write-Host 'This script only runs .NET restore/build/test checks.' -ForegroundColor Yellow
Write-Host 'It will not start the UI, start or install a Windows Service, or modify DNS, system proxy, WinDivert, zapret, xray, or other runtime behavior.' -ForegroundColor Yellow

Write-Section 'Checking prerequisites'
if (-not (Get-Command dotnet -ErrorAction SilentlyContinue)) {
    Write-Error 'The .NET SDK command "dotnet" was not found. Install the .NET SDK and ensure dotnet is on PATH.'
    exit 1
}
Write-Host 'dotnet is available.' -ForegroundColor Green

Invoke-Check 'Running dotnet restore' { dotnet restore }
Invoke-Check 'Running dotnet build' { dotnet build }
Invoke-Check 'Running dotnet test' { dotnet test }

Write-Section 'Development checks passed'
Write-Host 'All local validation checks completed successfully.' -ForegroundColor Green
