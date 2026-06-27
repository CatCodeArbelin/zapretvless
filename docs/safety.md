# Safety boundaries

PR-01 bootstrap имеет жёсткие границы безопасности:

- PR-01 не запускает Xray.
- PR-01 не запускает Zapret.
- PR-01 не запускает WinDivert.
- PR-01 не меняет DNS/proxy/routes.
- PR-01 не устанавливает service.
- PR-01 не запускает engine binaries и не требует их наличия для проверок.
