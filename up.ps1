param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]] $Arguments
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$repoRoot = $PSScriptRoot
$devUpScript = Join-Path $repoRoot 'scripts/dev-up.ps1'

if (-not (Test-Path $devUpScript)) {
    throw "Missing startup script: $devUpScript"
}

& $devUpScript @Arguments
