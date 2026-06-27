param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$solutionPath = Join-Path $repoRoot 'zapretvless.sln'

if (-not (Get-Command dotnet -ErrorAction SilentlyContinue)) {
    throw 'dotnet SDK was not found. Install .NET 8 SDK first.'
}

if (-not (Test-Path $solutionPath)) {
    throw "Solution file not found: $solutionPath"
}

Write-Host 'PR-01 safe check: UI, service, engines and network runtime are not started.'

dotnet restore $solutionPath
dotnet build $solutionPath --configuration Release
dotnet test $solutionPath --configuration Release
