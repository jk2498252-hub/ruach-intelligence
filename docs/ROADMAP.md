# RUACH Intelligence roadmap

Status labels: **DONE** is implemented and tested locally; **PLANNED** is not implemented. Module order is a dependency guide, not a promise of dates. Version numbers below are product milestones, not software package versions.

| Version | Module | Deliverable | Status |
| --- | --- | --- | --- |
| V0.0 | M1 Structural Core | Contracts, event ledger, local database, operator-gated text proof | DONE |
| V0.0 | M2 Scripture Data Layer | M2.1: two-verse gate; M2.2: complete ENGWEBP 66-book import; M2.3: complete SWHONEN import and operator choice; additional editions later | IN PROGRESS (M2.1–M2.3 DONE) |
| V0.0 | M3 Audio & Transcription | M3.1: PCM WAV ingress; M3.2: microphone; M3.3: optional provider adapter and WER evaluator | IN PROGRESS (M3.1–M3.3 DONE) |
| V0.0 | M4 Scripture Detection | M4.1: names for 66 books; M4.2: held proposals; M4.3: labeled regression set and numeric-to range; contextual/quotation/semantic later | IN PROGRESS (M4.1–M4.3 DONE) |
| V0.0 | M5 Evaluation Laboratory | M5.1: local aggregate metrics and provenance declarations; permissioned corpus and field estimates later | IN PROGRESS (M5.1 DONE) |
| V0.1 | M6 Operator Console | M6.3b: local credentials, owned sessions, admin assignment and explicit projector handoff; pilot authorization later | IN PROGRESS (M6.3b DONE) |
| V0.1 | M7 Presentation | Versioned projector state, persistent safe presets, authenticated private preview, clean broadcast output | DONE (M7.1–M7.4) |
| V0.1 | M8 Live Session | Persisted prepared → live → ended lifecycle, live gates, immutable ended boundary, owner/admin post-end audit access | DONE (M8.1–M8.2) |
| V0.1 | M9 Sermon Archive | Deterministic immutable archive, bounded metadata catalog and authorized single-record retrieval | DONE (M9.1–M9.2) |
| V0.1 | M10 Congregation Live | Tokenized read-only live scripture, explicit operator notes, optional authorized QR delivery | DONE (M10.1–M10.3) |
| V0.1 | M11 Resilience | Startup reconciliation, transaction/integrity degraded mode, external-dependency/offline failure behavior | DONE (M11.1–M11.3) |
| V0.2 | M12 Sermon Intelligence | Reviewed archive-bound drafts and optional provider-neutral model draft adapter | DONE (M12.1–M12.2) |
| V0.2 | M13 Communication | Reviewed WhatsApp/video drafts plus optional provider-neutral model proposals with separate human approval | DONE (M13.1–M13.2) |
| V0.2 | M14 Content Intelligence | Archive-grounded reviewed chapter/excerpt/clip suggestions plus optional model proposals; no media cutting/publishing | DONE |
| V0.3 | M15 Church Memory | Immutable owner/admin-scoped lexical search index built only from approved sermon intelligence | DONE |
| V0.3 | M16 Ask RUACH | Read-only grounded answers from approved Church Memory and approved content time ranges, with citation whitelisting | DONE |
| V0.3 | M17 Knowledge Governance | Append-only correction, suppression and restore overlays without deleting sealed evidence | DONE |
| V0.4 | M18 Multilingual Intelligence | Tested English/Kiswahili code switching, later languages | PLANNED |
| V0.4 | M19 Discipleship | Reviewed weekly and small-group material | PLANNED |
| V0.4 | M20 Member Intelligence | Saved notes and church-scoped assistant | PLANNED |
| Production | M21 Security & Privacy | Identity, authorization, encryption, retention | PLANNED |
| Production | M22 Deployment & Updates | Installer, updates, restore and diagnostics | PLANNED |
| Production | M23 Church Pilots | On-site evaluation and failure reporting | PLANNED |
| Production | M24 Commercial Platform | Tenancy, billing and operations | PLANNED |

Security and privacy work begins at M1; M21 is the production hardening gate, not permission to postpone security until launch.

## M1 crumbs and acceptance

1. **M1.1 Architecture:** local Python core, SQLite ledger, provider-neutral contracts; no external dependency in proof. ✓
2. **M1.2 Repository:** package, docs, tests, future app boundaries. ✓
3. **M1.3 Contracts:** session, audio chunk, transcript segment, scripture candidate, scripture event. ✓
4. **M1.4 Events:** append-only typed ledger, session ordering, approval and display transitions. ✓
5. **M1.5 Database:** migration, referential integrity, uniqueness, version and persistence. ✓
6. **M1.6 Evidence:** decision record, evidence labels, translation and privacy gates. ✓
7. **M1.7 Tests:** positive, false positive, gate and persistence checks. ✓

**Next batch: M18–M20.** Extend the approved-memory layer for explicit English/Kiswahili language metadata and code-switch-aware retrieval, add reviewed discipleship material, and add a consent-first member workspace without inferred member profiling. M14–M17 are complete and remain review-first/read-only where applicable. M5.2 remains a field-evidence gate: obtain reviewed permission and a human-labeled holdout corpus, then measure transcription and detector errors on real English/Kiswahili audio. M4.4 contextual and quotation recognition depends on that evidence before it enters the display path. M3.4 requires permissioned recordings, accuracy/latency measures and browser-microphone testing. Other editions need individual source and rights review.

Before a church pilot, finish operator authentication, full spoken reference detection, offline performance and on-site accuracy evaluation. The [cross-model review](reviews/M2.1_DISPOSITION.md) is triaged against source and tests. Model agreement alone is not a gate.
