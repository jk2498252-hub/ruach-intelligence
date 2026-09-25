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

## Next slice

M10.2 adds optional operator-authored congregation notes with explicit publication controls. QR rendering remains a later M10 slice.
