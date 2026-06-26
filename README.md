# Arbelin One

Arbelin One is a bootstrap Windows client solution. PR-01 focuses on creating a safe development baseline: solution structure, restore/build/test scripts, and documentation for local checks. It does **not** start network engines or enable a real DPI/VLESS runtime.

## What PR-01 creates

PR-01 establishes the first repository baseline for the Windows client:

- `zapretvless.sln` with client, service, shared, and test projects.
- `up.ps1` as the repository-root Windows entry point for bootstrap validation.
- `scripts/dev-up.ps1` for the safe PR-01 bootstrap flow.
- `scripts/dev-check.ps1` for restore/build/test validation without launching runtime components.
- Docker Compose check mode for container-friendly validation paths.

## How to build the solution

From the repository root, build the solution with the .NET SDK:

```powershell
dotnet restore .\zapretvless.sln
dotnet build .\zapretvless.sln --configuration Release
```

On Windows, you can also run the bootstrap entry point:

```powershell
.\up.ps1
```

`up.ps1` delegates to `scripts/dev-up.ps1`, which restores, builds, and tests the solution as a safe bootstrap check.

## How to run checks

Run the local PowerShell checks from the repository root:

```powershell
.\scripts\dev-check.ps1
```

The same checks can be run manually with the .NET CLI:

```powershell
dotnet restore .\zapretvless.sln
dotnet build .\zapretvless.sln --configuration Release
dotnet test .\zapretvless.sln --configuration Release
```

Docker Compose is available only for safe check/build workflows:

```bash
docker compose up --build
```

## PR-01 network/runtime safety

PR-01 intentionally does not start network engines. The bootstrap scripts do not install or start a Windows Service, do not launch zapret/xray/WinDivert, and do not modify DNS, proxy, routing, or traffic interception settings.

Engine binaries are not required to run PR-01 checks. Any real DPI/VLESS runtime integration is outside the PR-01 bootstrap scope.

## Next step

PR-02 UI Skeleton is planned separately after PR-01 is merged.
