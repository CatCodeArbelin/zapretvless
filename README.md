# Arbelin One

## Статус

PR-01 — это только bootstrap проекта Arbelin One. Репозиторий содержит базовую структуру solution, безопасные скрипты проверки, документацию и пустые каталоги для будущих компонентов.

В PR-01.2 нормализованы форматирование и проверки bootstrap. Новая runtime-функциональность не добавлялась.

## Что создано в PR-01

- `zapretvless.sln` — .NET solution для client, service, shared и tests проектов.
- `src/Arbelin.One.Client` — заготовка Windows UI-проекта.
- `src/Arbelin.One.Service` — заготовка service-проекта без установки и запуска Windows Service.
- `src/Arbelin.One.Shared` — shared-модели bootstrap.
- `src/Arbelin.One.Tests` — базовые тесты bootstrap.
- `up.ps1` — корневой entry point для локального safe bootstrap запуска.
- `scripts/dev-up.ps1` — restore/build/test и попытка запуска client UI на Windows.
- `scripts/dev-check.ps1` — restore/build/test без запуска UI и runtime-компонентов.
- `docker-compose.yml` — container-friendly safe-check service.
- `docs/`, `LICENSES/`, `configs/`, `engines/` — стартовая структура документации, конфигурации и будущих engine artifacts.

## Быстрый запуск на Windows

Из корня репозитория:

```powershell
.\up.ps1
```

Или напрямую:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\dev-up.ps1
```

`dev-up.ps1` выполняет только следующие команды:

```powershell
dotnet restore .\zapretvless.sln
dotnet build .\zapretvless.sln --configuration Release
dotnet test .\zapretvless.sln --configuration Release
dotnet run --project .\src\Arbelin.One.Client\Arbelin.One.Client.csproj
```

Если текущая среда не поддерживает запуск Windows UI, это является ограничением среды. Скрипт не должен обходить его сетевой логикой или запуском engine-компонентов.

## Safe check

Для проверки без запуска UI используйте:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\dev-check.ps1
```

`dev-check.ps1` выполняет только:

```powershell
dotnet restore .\zapretvless.sln
dotnet build .\zapretvless.sln --configuration Release
dotnet test .\zapretvless.sln --configuration Release
```

## Docker Compose check mode

Docker Compose используется только для безопасной container-friendly проверки shared/tests проектов:

```powershell
docker compose config
docker compose run --rm safe-check
```

Compose-файл не запускает Windows UI, Windows Service, Xray, Zapret или WinDivert, не публикует порты, не включает privileged mode и не меняет сеть хоста.

## Runtime safety

В PR-01 и PR-01.2 не реализованы и не запускаются runtime-компоненты:

- VLESS/DPI логика не реализована.
- Xray не запускается.
- Zapret не запускается.
- WinDivert не запускается.
- DNS, proxy и routes не меняются.
- Windows Service не устанавливается и не запускается.
- TUN mode, kill switch, hybrid logic, installer, auto-update и telemetry отсутствуют.

## Engine binaries

Каталоги `engines/xray` и `engines/zapret` являются placeholders для будущих PR.

Engine binaries не требуются для PR-01 checks и PR-01.2 checks. Отсутствие `xray.exe`, `winws.exe` или WinDivert binaries не является ошибкой bootstrap-проверок.

## Что не реализовано

- PR-02 UI Skeleton не делался.
- VLESS parser не реализован.
- Xray config generator не реализован.
- ProcessSupervisor, XrayEngine и ZapretEngine не реализованы.
- Управление DNS/proxy/routes не реализовано.
- Любая DPI/VLESS runtime-логика не реализована.

## Следующий шаг

После merge PR-01.2 можно переходить к PR-02 UI Skeleton.
