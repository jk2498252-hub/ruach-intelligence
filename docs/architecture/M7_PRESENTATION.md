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

## Deferred to later M7 slices

Theme/layout presets, broadcast-specific output, transitions, operator preview, and visual device testing are not part of M7.1.


## M7.2 accepted slice

M7.2 adds operator-selectable presentation presets while keeping the renderer closed to arbitrary CSS or HTML.

- Themes are allow-listed: `dark`, `light`, and `high_contrast`.
- Layouts are allow-listed: `centered` and `lower_third`.
- Preferences are persisted in SQLite and survive restart.
- A preset change advances the presentation revision so connected projector clients update without a scripture-state mutation.
- Invalid theme/layout values fail closed before any database or revision change.
- The browser maps the returned enum values only to static CSS selectors; there is no `style.cssText`, arbitrary style string, or HTML injection path.
- When a projector session is selected, a `presentation.changed` ledger event records the actor and selected preset.

Focused M7.2 tests plus the entire existing suite pass: **57 tests**.
