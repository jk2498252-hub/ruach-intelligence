# M8 Live Session Engine

## M8.1 accepted slice — explicit service lifecycle

The operator path now uses a persisted service lifecycle:

`prepared → live → ended`

A newly-created operator session is prepared. The operator must explicitly start the live service before RUACH accepts sermon input or routes scripture to the projector.

### Persisted state

Migration `011_live_session_lifecycle.sql` adds `live_session_state` with phase, live-start, end and update timestamps. Existing active development sessions migrate as live and existing ended sessions migrate as ended.

### Live gates

The live phase is required for typed transcript ingestion, microphone/WAV ingestion, projector selection and Go Live/scripture display. This prevents a prepared or ended service from reaching the live presentation path through another input route.

### Transitions

Starting a service records `session.live_started`. Ending a service clears/releases projector output, hides a current verse when necessary, marks the session ended, records `session.ended`, and makes the service non-restartable.

### Compatibility note

The lower-level `Core.start_session(..., live=True)` helper retains its historical immediate-live default for existing unit fixtures and development calls. The actual HTTP/operator workflow uses `prepare_session()`, so the product path requires the explicit transition.

### Acceptance

The complete M1–M8.1 suite passes **67 tests**. Tests cover persistence across restart, refusal to restart an ended service, ending while scripture is live, HTTP refusal before Start Live and after End Live, operator controls, and audio using the same live gate.

## M8.2 accepted slice — immutable ended-service boundary

Once a service is ended, operator mutations are refused: approve/reject, correction, held-candidate resolution/dismissal and private preview are all closed, in addition to the M8.1 live input/output gates.

An ended service is auditable but not actionable. `service_summary()` exposes lifecycle timestamps and aggregate counts only; it intentionally contains no sermon transcript text or canonical scripture payload. The service owner and an administrator may read the ended-service summary and ordered ledger after restart, while unrelated operators are denied. The review queue refuses ended services and directs callers to the read-only summary.

## M8 acceptance

The complete M1–M8 suite passes **71 tests**. Archive construction remains M9.
