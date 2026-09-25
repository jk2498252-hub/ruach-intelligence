# M11 Resilience

## M11.1 accepted slice — startup reconciliation

On Core startup RUACH reconciles volatile live-output state inside one SQLite transaction.

- A projector target is preserved only if its session is still live.
- A stale projector target is cleared; a displayed verse is hidden; the presentation revision advances; recovery events are audited as system_recovery.
- An enabled congregation share is preserved only for a live service.
- A stale congregation share is disabled with an audit event.
- Valid live projector/share state survives restart unchanged.
- The reconciler never starts a prepared service, revives an ended service, or recreates a public share token.

GET /api/health exposes only content-free diagnostics: schema version, projector-active boolean, active congregation-share count and live-session count. It exposes no transcript, scripture, archive, session or operator identifiers.

The complete M1–M11.1 suite passes **90 tests**.

## M11.2 accepted slice — interrupted-write and database integrity recovery

- Store startup runs SQLite `PRAGMA integrity_check` before migrations and again after migration.
- A failed integrity preflight enters content-free degraded mode instead of attempting startup reconciliation or normal operator access.
- Degraded mode refuses transactional mutations, reports `/api/health`, and makes projector/broadcast/congregation public output fail blank.
- Operator APIs return HTTP 503 while persistence integrity is failed.
- Transaction rollback is hardened so a rollback failure itself marks the store degraded.
- Failure injection late in End Live proves lifecycle, projector, share, presentation revision, event ledger and archive sealing remain atomic: either the whole transition commits or none of it does.
- A physically corrupted SQLite file is detected in tests and is not treated as a valid service database.

The complete M1–M11.2 suite passes **93 tests**.

## Next slice

M11.3 will verify external-dependency/offline behavior so provider/network failure cannot damage local live-service state or leave stale output.
