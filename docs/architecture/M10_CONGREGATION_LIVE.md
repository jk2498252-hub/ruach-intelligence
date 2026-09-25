# M10 Congregation Live

## M10.1 accepted slice — opt-in live scripture link

M10.1 adds an explicitly enabled, read-only congregation surface for the current approved live scripture.

- Enabling a share creates a high-entropy URL-safe public token.
- SQLite stores only SHA-256 of the token, never the bearer token itself.
- Rotating the share invalidates the earlier token.
- Disabling sharing or ending the service makes the public token return a blank inactive state.
- Public JSON contains no session ID, operator identity, scripture-event ID, segment ID, archive ID, transcript, ledger or archive payload.
- Public content is limited to the current approved/displayed scripture reference, canonical verse text, translation ID, publisher attribution, license URL and canonical notes.
- Rights/text integrity are rechecked through the existing live-display validation path.
- The congregation page uses textContent and fails blank when inactive/disconnected.

The complete M1–M10.1 suite passes **83 tests**.

## M10.2 accepted slice — explicit congregation notes

- Notes are operator-authored only; there is no automatic transcript or AI promotion.
- Note text is capped at 500 characters and must be explicitly published.
- Unpublished or cleared notes never appear publicly.
- The audit ledger stores note length and SHA-256 only, not note text.
- Ending the service closes publication.

## M10.3 accepted slice — optional QR delivery

- QR support is isolated in the optional `qrcode` extra; core operation remains dependency-free.
- QR generation requires a currently active share token and owner/admin authorization.
- The operator supplies an explicit HTTP(S) public base URL; RUACH does not guess a deployment address.
- Credentialed, query-string, fragment and non-HTTP base URLs are rejected.
- The QR endpoint returns SVG and embeds no internal session/operator identifiers.

## M10 acceptance

The complete M1–M10 suite passes **87 tests**.
