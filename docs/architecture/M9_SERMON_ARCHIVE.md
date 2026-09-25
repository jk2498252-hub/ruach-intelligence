# M9 Sermon Archive

## M9.1 accepted slice — deterministic sealed service archive

When a live service transitions to `ended`, RUACH automatically seals an immutable archive record in the same transaction.

### Archive contents

Archive schema version 1 preserves service lifecycle metadata and owner identity; ordered transcript segments with timing/languages/provider provenance; audio metadata only (timing, media type, SHA-256, byte count, creation time and linked transcript, never duplicated raw audio bytes); ordered scripture events including canonical text and operator/display states; and the complete ordered event-ledger provenance through `session.ended`.

### Determinism and integrity

The manifest is canonical UTF-8 JSON with sorted keys and compact separators. SHA-256 is computed over those exact bytes. The archive ID is derived from the digest prefix. `archive_record()` recomputes SHA-256 before returning a record and fails on mismatch.

### Immutability

Migration `012_sermon_archive.sql` creates the archive table and database triggers that require an ended service and reject UPDATE or DELETE on sealed archives. Sealing is idempotent.

### Access and scope

`GET /api/archive?session_id=...` is read-only for the service owner or an administrator. Unrelated operators are denied. M9.1 is evidence preservation, not sermon interpretation: no summaries, titles, themes, chapters, semantic search, clips or theological conclusions are generated.

### Acceptance

The complete M1–M9.1 suite passes **75 tests**.

## Next slice

M9.2 will add a bounded archive catalog for owner/admin metadata listing. Search inside sermon content remains a later Church Memory capability.
