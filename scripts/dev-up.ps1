<#
.SYNOPSIS
    Safely restores, builds, and tests the solution for local development.

.NOTES
    PR-01 bootstrap is intentionally safe: it does not start engines, Windows
    services, DNS/proxy/route changes, network interception, or any network mode.
#>

[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Write-Section {
    param([Parameter(Mandatory = $true)][string]$Message)
    Write-Host "`n==> $Message" -ForegroundColor Cyan
}

$repoRoot = Split-Path -Parent $PSScriptRoot
Set-Location $repoRoot

Write-Section 'Safety notice'
Write-Host 'PR-01 safe bootstrap only: this script does not start engines, Windows services, DNS/proxy/route changes, network interception, or any network mode.' -ForegroundColor Yellow
Write-Host 'It only verifies dotnet availability, then restores, builds, and tests zapretvless.sln.' -ForegroundColor Yellow

Write-Section 'Checking prerequisites'
if (-not (Get-Command dotnet -ErrorAction SilentlyContinue)) {
    Write-Error 'The .NET SDK command "dotnet" was not found. Install the .NET SDK and ensure dotnet is on PATH.'
    exit 1
}
Write-Host 'dotnet is available.'

Write-Section 'Restoring solution'
dotnet restore zapretvless.sln

Write-Section 'Building solution'
dotnet build zapretvless.sln --configuration Release

Write-Section 'Testing solution'
dotnet test zapretvless.sln --configuration Release
