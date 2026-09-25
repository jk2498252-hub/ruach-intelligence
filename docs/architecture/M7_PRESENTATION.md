# M7 Presentation Engine

## M7.1 accepted slice

M7.1 turns the M6 projector route into a safer presentation surface without changing scripture detection or approval rules.

### Invariants

- `/api/display` returns one atomic projector snapshot: persisted `revision`, selected `session_id`, `changed_at`, and either one currently validated `scripture_event` or `null`.
- A visible-state mutation advances the singleton presentation revision. The revision is persisted in SQLite and survives process restart.
- Source/rights validation still happens at read time. If the current canonical text no longer validates, the verse is hidden and the presentation revision advances.
- The public display has one `render(snapshot)` path and one `clearSlide(...)` path. Clearing removes the reference, verse text, notes, attribution and license target rather than leaving stale scripture on screen.
- The browser ignores responses from older overlapping requests and snapshots with a lower revision. A delayed response therefore cannot resurrect scripture after a later clear or disconnect.
- Scripture is assigned with `textContent`; presentation data is never interpreted as HTML.
- Responsive CSS uses bounded `clamp()` sizing, a 4:3 media rule, a short-screen rule, balanced wrapping and bounded notes so long verses degrade by wrapping rather than viewport-width font explosion.

### Failure behavior

On a poll failure, all scripture fields are cleared immediately and a separate connection-status line reports that the display is waiting to reconnect. A later successful snapshot restores only the current validated server state.

### Persistence

Migration `009_presentation_state.sql` introduces a singleton projector revision. This is presentation synchronization state, not a second scripture source of truth.

### Tests

`tests/test_presentation.py` covers revision changes and restart recovery, automatic clearing after rights invalidation, the public display API envelope, stale-response and stale-revision guards, and responsive long-text-safe rendering.

The complete M1–M7.1 unit suite passes: **53 tests**. Physical projector/browser appearance remains an on-device acceptance test and is not claimed by the automated suite.

## M7.2 accepted slice — safe presentation presets

- Themes are allow-listed: `dark`, `light`, `high_contrast`.
- Layouts are allow-listed: `centered`, `lower_third`.
- Preferences persist across restart and advance the shared presentation revision.
- Invalid values fail before any state change; the browser maps enums to static CSS only.

## M7.3 accepted slice — authenticated private preview and output hardening

- Only a signed-in operator who owns the session can fetch an approved preview.
- Preview revalidates canonical text and rights but does not change display state, ledger, projector assignment, or presentation revision.
- Preview and public projector snapshots have explicit incompatible output tags.
- Public display query parameters cannot select or preview arbitrary scripture events.
- HTML responses add no-store, CSP, frame-denial, referrer and same-origin resource headers.
- Projector rendering fails clear on disconnect/invalid output and includes portrait/safe-area rules.

## M7.4 accepted slice — broadcast output

- `/broadcast` and `/api/broadcast` are read-only output surfaces for livestream/browser-source capture.
- Broadcast state is derived from the projector snapshot; there is no second live scripture state.
- The broadcast client accepts only the broadcast output tag and fails blank on fetch/output errors.
- Projector and broadcast share the same canonical verse, revision, rights revalidation, theme/layout and attribution.

## M7 acceptance

The complete M1–M7 suite passes **63 tests**. Physical projector, capture-card, OBS/browser-source and church-room visual tests remain on-device acceptance work before a pilot.