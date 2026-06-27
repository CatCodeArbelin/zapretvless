# Документация Arbelin One

Arbelin One / zapretvless находится в статусе PR-01 bootstrap. Созданы базовые .NET 8 проекты клиента, worker service, shared library и тестов.

PR-02 UI Skeleton ещё не делался. Текущий bootstrap не содержит runtime-логики, не запускает Xray/Zapret/WinDivert и не меняет сетевые настройки системы.

## Границы PR-01

- VLESS parser не реализован.
- XrayEngine не реализован.
- ZapretEngine не реализован.
- Xray, Zapret и WinDivert не запускаются.
- DNS, proxy и routes не меняются.
- PR и merge делает человек вручную.
