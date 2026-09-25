# M20 Member Workspace

M20 intentionally implements a privacy-conservative member workspace rather than inferred member analytics.

- Workspace creation requires explicit consent.
- A high-entropy token is returned once; SQLite stores only its SHA-256.
- No member name or email is required.
- Members may save bounded private notes and query approved, non-suppressed Church Memory.
- Personal note text is **not** sent to the Ask RUACH provider.
- Revocation invalidates the token and deletes saved note bodies.
- RUACH does not infer spiritual state, attendance risk, sin risk, member rank, ideology, or similar sensitive profiles.

Production privacy lifecycle and security controls remain M21.
