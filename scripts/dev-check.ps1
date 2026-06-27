[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
Set-Location $repoRoot

if (-not (Get-Command dotnet -ErrorAction SilentlyContinue)) {
    Write-Error 'dotnet is required for PR-01 safe checks.'
    exit 1
}

dotnet restore .\zapretvless.sln
dotnet build .\zapretvless.sln --configuration Release
dotnet test .\zapretvless.sln --configuration Release
