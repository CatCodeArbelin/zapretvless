# Arbelin One

## Статус

PR-01 bootstrap. Реальная VLESS/DPI runtime-логика ещё не реализована.

## Что создано в PR-01

- .NET solution
- WPF client
- Worker Service skeleton
- Shared library
- xUnit tests
- PowerShell startup scripts
- Docker Compose safe-check mode
- docs/configs/LICENSES/engines placeholders

## Быстрый запуск на Windows

```powershell
.\up.ps1
```

## Safe check

```powershell
.\scripts\dev-check.ps1
```

## Docker Compose check mode

```powershell
docker compose up --build
```

Docker Compose не запускает Windows UI, Windows Service, Xray, Zapret или WinDivert.

## Runtime safety

PR-01 не запускает Xray/Zapret/WinDivert и не меняет DNS/proxy/routes.

## Engine binaries

Бинарники не входят в репозиторий:

* engines/xray/xray.exe
* engines/zapret/winws.exe
* engines/zapret/winws2.exe
* engines/zapret/WinDivert64.sys

## Что не реализовано

* VLESS parser
* Xray config generator
* Process supervisor
* XrayEngine
* ZapretEngine
* Hybrid mode
* DNS/proxy/routes changes

## Следующий шаг

После успешного build/test и запуска `.\up.ps1` можно переходить к PR-02 UI Skeleton.
