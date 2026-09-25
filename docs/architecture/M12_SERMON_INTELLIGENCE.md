# M12 Sermon Intelligence

## M12.1 accepted slice — reviewed archive-bound drafts

M12.1 creates the governance container before adding automatic generation. Sermon intelligence is separate from the immutable live-service ledger and archive.

### Evidence binding

- A draft can be created only for an existing sealed M9 archive.
- The draft stores the exact source archive SHA-256 and verifies it on read.
- Draft payloads are canonical JSON with their own SHA-256.
- Scripture citations are represented as scripture-event IDs and every cited event must already exist in the sealed archive.

### Draft schema

A draft contains a bounded title, summary, sermon-point list and archive-backed scripture-event references. Source provenance is explicit: `human_authored` or `model_draft`, plus a source label. Creation always produces status `draft`.

### Human review

- Approval/rejection is a separate authenticated action.
- Draft content is immutable after creation; revisions require a new draft.
- Review activity is stored in a separate append-only audit table, so post-sermon review does not rewrite the M9 service ledger.
- At most one draft may be approved per archive at a time.
- Owner/admin authorization applies to draft listing, creation and decisions. There is no public intelligence endpoint.

### Acceptance

The complete M1–M12.1 suite passes **98 tests**. No automatic model generation is included in M12.1.

## M12.2 accepted slice — optional provider-neutral model draft adapter

- Model calls consume a bounded structured projection of the already-verified sealed archive.
- The provider call happens outside the SQLite transaction.
- Provider/model labels, archive hash, canonical model-input hash, canonical response hash, requesting operator and timestamp are stored in an immutable model-run provenance table.
- Provider output is revalidated by RUACH's existing title/summary/point bounds and archive-event citation rules before any draft is committed.
- Provider/network failures and invalid citations create no draft and no provenance row.
- Manual/API callers cannot claim `source_kind=model_draft`; only the configured provider path can create that provenance class.
- The model-generation HTTP endpoint is private to the archive owner/admin and returns 501 when no provider adapter is configured.
- Generated material always enters status `draft`; only the separate M12.1 human review action can approve or reject it.

## M12 acceptance

The complete M1–M12 suite passes **102 tests**. M12 provides reviewed sermon intelligence, not autonomous church doctrine or publication.
