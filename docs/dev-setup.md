# Dev setup

## Windows bootstrap startup

```powershell
.\up.ps1
```

Команда выполняет restore/build/test, создаёт локальные bootstrap-папки и запускает WPF UI.

## Safe check без UI

```powershell
.\scripts\dev-check.ps1
```

Команда выполняет только restore/build/test для solution.

## Docker Compose check

```powershell
docker compose up --build
```

Compose-режим предназначен только для безопасной проверки shared/tests в .NET SDK контейнере.
