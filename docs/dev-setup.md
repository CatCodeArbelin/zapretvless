# Dev setup

Ниже перечислены безопасные команды сборки и проверки для PR-01 bootstrap. Они предназначены для локальной валидации структуры решения и конфигурации без запуска сетевых движков или внешних runtime-binaries.

## Проверка окружения

```powershell
dotnet --info
```

## Восстановление зависимостей

```powershell
dotnet restore zapretvless.sln
```

## Сборка Release

```powershell
dotnet build zapretvless.sln --configuration Release
```

## Тесты Release

```powershell
dotnet test zapretvless.sln --configuration Release
```

## Проектный dev-check

```powershell
pwsh -File scripts/dev-check.ps1
```

## Проверка Docker Compose конфигурации

```powershell
docker compose config
```
