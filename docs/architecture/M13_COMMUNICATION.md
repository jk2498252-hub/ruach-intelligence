# M13 Communication Engine

## M13.1 accepted slice — reviewed communication drafts

M13.1 creates a second review boundary between approved sermon intelligence and outward-facing communication.

- A communication draft can be created only from an **approved** M12 intelligence draft.
- The communication record stores the exact source intelligence draft ID and payload SHA-256.
- Supported initial channels are `whatsapp_recap` and `video_description`.
- Draft body text is bounded, SHA-256 hashed, and immutable after creation.
- Communication approval/rejection is a separate authenticated human action; approving the M12 sermon-intelligence draft does not authorize outward communication.
- Communication review activity is append-only and retained separately from the live-service ledger and M12 review audit.
- At most one approved communication per source/channel may exist at a time.
- Owner/admin authorization applies to creation, listing and decisions.
- There is intentionally **no publish endpoint** in M13.1.

The complete M1–M13.1 suite passes **105 tests**.

## Next slice

M13.2 may add an optional provider-neutral communication-draft generator, but generated copy must enter only as `draft` with immutable provider/model/source provenance and remain subject to the M13.1 human approval gate.
