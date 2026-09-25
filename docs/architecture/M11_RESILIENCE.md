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

## M11.3 accepted slice — offline/external dependency behavior

- External transcription calls occur outside the database lock.
- Provider/network failure leaves locally captured audio intact, creates no transcript/scripture side effect, and does not disturb projector or congregation output.
- The operator can fall back to a manual/local transcript after provider failure.
- A late provider response arriving after End Live is rejected by the existing live-session gate and cannot append transcript/scripture state to an ended service.
- Local scripture presentation and congregation output do not depend on external transcription availability once local state is committed.

The complete M1–M11 suite passes **95 tests**.

## M11 acceptance

M11 now covers startup reconciliation, atomic persistence/degraded mode, and external-dependency failure behavior. Device/network chaos testing in a real church remains part of M23 pilot validation.
