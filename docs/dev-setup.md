# Dev setup

## Windows bootstrap startup

```powershell
.\up.ps1
```

Команда выполняет restore/build/test, создаёт локальные bootstrap-папки и запускает WPF UI. Это только PR-01 bootstrap: VLESS parser, XrayEngine и ZapretEngine не реализованы.

## Safe check без UI

```powershell
.\scripts\dev-check.ps1
```

Команда выполняет только restore/build/test для solution. Она не запускает Xray, Zapret, WinDivert или Windows Service и не меняет DNS/proxy/routes.

## Docker Compose check

```powershell
docker compose up --build
```

Compose-режим предназначен только для безопасной проверки shared/tests в .NET SDK контейнере. Он не запускает WPF UI, Windows Service, Xray, Zapret или WinDivert.

## Workflow

PR и merge делает человек вручную. Автоматический push, merge и создание PR не являются частью PR-01 bootstrap.
