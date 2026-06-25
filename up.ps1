$repoRoot = $PSScriptRoot
$devUp = Join-Path $repoRoot 'scripts/dev-up.ps1'

& $devUp @args
exit $LASTEXITCODE
