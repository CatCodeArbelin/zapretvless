# Safety boundaries

PR-01 bootstrap имеет жёсткие границы безопасности. PR-02 UI Skeleton ещё не делался, а runtime-логика отсутствует.

- VLESS parser не реализован.
- XrayEngine не реализован.
- ZapretEngine не реализован.
- PR-01 не запускает Xray.
- PR-01 не запускает Zapret.
- PR-01 не запускает WinDivert.
- PR-01 не меняет DNS/proxy/routes.
- PR-01 не устанавливает и не запускает Windows Service.
- PR-01 не запускает engine binaries и не требует их наличия для проверок.
- PR и merge делает человек вручную.
