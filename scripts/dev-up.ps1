[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
Set-Location $repoRoot

if (-not $IsWindows) {
    Write-Error 'dev-up.ps1 is intended for local Windows development startup.'
    exit 1
}

if (-not (Get-Command dotnet -ErrorAction SilentlyContinue)) {
    Write-Error 'dotnet is required for PR-01 local startup.'
    exit 1
}

dotnet restore .\zapretvless.sln
dotnet build .\zapretvless.sln --configuration Release
dotnet test .\zapretvless.sln --configuration Release

$appDataRoot = Join-Path $env:LOCALAPPDATA 'ArbelinOne'
New-Item -ItemType Directory -Force -Path $appDataRoot | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $appDataRoot 'logs') | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $appDataRoot 'configs') | Out-Null

Write-Host 'PR-01 bootstrap mode: Xray, Zapret, WinDivert, DNS, proxy and routes are not touched.' -ForegroundColor Yellow

dotnet run --project .\src\Arbelin.One.Client\Arbelin.One.Client.csproj
