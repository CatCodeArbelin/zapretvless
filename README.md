# zapretvless

Vless DPI client

## One-command startup

### Primary Windows startup

Use one of these commands from a Windows PowerShell prompt at the repository root:

```powershell
.\up.ps1
```

or run the development startup script directly:

```powershell
.\scripts\dev-up.ps1
```

The Windows startup script is intended to prepare and launch the real Windows desktop client. It:

- restores dependencies, builds the solution, and runs tests;
- checks that required engine binaries are present;
- creates local runtime/configuration folders when needed;
- starts the Windows Service only if it is already installed;
- launches the WPF UI.

### Docker Compose check mode

Docker Compose is available only as a check/build mode for container-friendly parts of the repository:

```bash
docker compose up --build
```

or, for the development service:

```bash
docker compose up --build dev
```

Docker is **not** used to run the real Windows desktop client. Docker must not manage Windows GUI processes, the Windows Service, WinDivert, DNS settings, system proxy settings, zapret, or xray on the host.

## Troubleshooting

### Missing Docker

Docker is only required for Docker Compose check mode. If `docker compose up --build` fails because Docker is missing, install Docker Desktop or skip Compose and use the Windows startup flow with `.\up.ps1` or `.\scripts\dev-up.ps1` from Windows PowerShell.

### Missing .NET SDK

The Windows startup scripts run restore/build/test steps. If they fail because `dotnet` is not found or the SDK is missing, install the .NET SDK version required by the solution and verify it with:

```powershell
dotnet --info
```

### Missing engine binaries

The startup scripts check for required engine binaries before launching the client. If the check fails, place the required zapret/xray/WinDivert binaries in the expected local engine folders or follow the project setup instructions for obtaining them, then rerun the startup script.

### Service not installed

The startup script starts the Windows Service only when it is already installed. If the service is not installed, the script will not install or manage it automatically; install/register the service first, then rerun the startup script if service startup is required.

### WPF project not buildable inside Linux container

The WPF desktop client is a Windows application and may not build inside a Linux Docker container. This is expected. Use Docker Compose only for check mode, and build/run the real WPF client on Windows with `.\up.ps1` or `.\scripts\dev-up.ps1`.

## PR plan

### PR-01: Bootstrap solution

PR-01 establishes the baseline development and startup workflow for the repository. It must provide a single clear Windows entry point for local development, a Docker Compose check mode for safe container-friendly validation, and documentation that explains when to use each startup path.

#### Required files and documentation

- `docker-compose.yml`
- `up.ps1`
- `scripts/dev-up.ps1`
- `scripts/dev-check.ps1`
- README `One-command startup` section

#### Acceptance criteria

- `.\up.ps1` runs build/test checks and opens the UI.
- `docker compose up --build` runs safe checks only.
- Windows developer startup works without Docker.
- Missing engine binaries produce warnings but do not crash the app.

### PR-01.5: Dev startup polish

PR-01.5 improves the developer experience around the bootstrap workflow after PR-01 lands. It focuses on making startup output understandable for beginners, validating local prerequisites early, and preventing surprising system-level behavior during development.

#### Acceptance criteria

- Startup output is clear and beginner-friendly.
- Startup scripts include an admin mode check.
- Startup scripts check for required engine binaries.
- Startup scripts avoid silent failures.
- Startup scripts do not automatically start network mode.
