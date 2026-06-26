<#
.SYNOPSIS
    PR-01.2 safety placeholder.

.NOTES
    This script intentionally performs no runtime, service, engine, DNS, proxy,
    route, WinDivert, Xray, or Zapret actions during the bootstrap phase.
#>

[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host 'PR-01.2 bootstrap safety placeholder: no action was performed.' -ForegroundColor Yellow
Write-Host 'Service install/uninstall, network repair, engines, DNS, proxy, routes, and WinDivert are intentionally out of scope.' -ForegroundColor Yellow
