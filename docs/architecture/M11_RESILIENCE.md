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

## Next slice

M11.2 should inject interrupted writes and persistence failures, verify transaction atomicity/SQLite integrity, and force degraded startup rather than trusting a failed database.
