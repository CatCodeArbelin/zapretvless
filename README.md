# Arbelin One

## Статус

PR-01 — только bootstrap Windows-клиента Arbelin One / zapretvless. Runtime-логика не реализована и не запускается.

## Что создано в PR-01

- `.NET 8` solution `zapretvless.sln`.
- WPF desktop client `src/Arbelin.One.Client`.
- Worker Service skeleton `src/Arbelin.One.Service`.
- Shared library `src/Arbelin.One.Shared` с bootstrap-моделями.
- xUnit tests `src/Arbelin.One.Tests`.
- Безопасные PowerShell-скрипты, docs, configs placeholders и engine placeholders.

## Быстрый запуск на Windows

```powershell
.\up.ps1
```

Скрипт выполняет restore/build/test, создаёт локальные папки `%LOCALAPPDATA%\ArbelinOne`, `%LOCALAPPDATA%\ArbelinOne\logs`, `%LOCALAPPDATA%\ArbelinOne\configs` и запускает WPF UI.

## Safe check

```powershell
.\scripts\dev-check.ps1
```

Safe check выполняет только:

```powershell
dotnet restore .\zapretvless.sln
dotnet build .\zapretvless.sln --configuration Release
dotnet test .\zapretvless.sln --configuration Release
```

## Docker Compose check mode

```powershell
docker compose up --build
```

Docker Compose не запускает Windows UI, Windows Service, Xray, Zapret или WinDivert, не публикует порты, не использует host network и не меняет DNS/proxy/routes.

## Runtime safety

В PR-01 Xray/Zapret/WinDivert не запускаются. DNS, proxy и routes не меняются. Windows Service не устанавливается автоматически.

## Engine binaries

Engine binaries не нужны для PR-01 checks. `xray.exe`, `winws.exe`, `winws2.exe`, `WinDivert64.sys` и другие binaries не включены.

## Что не реализовано

- VLESS parser не реализован.
- XrayEngine не реализован.
- ZapretEngine не реализован.
- Xray config generator, ProcessSupervisor, TUN, kill switch, Hybrid logic, installer, auto-update и telemetry не реализованы.
- PR-02 UI Skeleton не делался.

## Следующий шаг

Человек вручную смотрит diff, создаёт PR и делает merge. PR и merge не выполняются автоматикой bootstrap-задачи.
