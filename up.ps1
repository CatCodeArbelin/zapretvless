<#
.SYNOPSIS
    Repository-root entry point for the safe PR-01 bootstrap flow.
#>

[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$repoRoot = $PSScriptRoot
$devUp = Join-Path $repoRoot 'scripts/dev-up.ps1'

& $devUp @args
exit $LASTEXITCODE
