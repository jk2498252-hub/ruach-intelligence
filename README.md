# RUACH Intelligence

RUACH is an evidence-first church service intelligence system. The tested local engineering checkpoint currently implements the structural core, Bible data layer, audio/transcription proof, scripture detection/regression harness, operator workflow, presentation, live-service lifecycle, immutable sermon archive, congregation live surface, resilience, reviewed sermon intelligence, reviewed communication, content suggestions, Church Memory, grounded Ask RUACH, knowledge governance, multilingual memory metadata, reviewed discipleship, a consent-first member workspace, security/privacy hardening, and deployment/update verification tooling.

## Engineering verification

The M1–M22 regression gate passes **128/128 tests across 40 test files**.

This is **not** a production-readiness or real-sermon-accuracy claim. The 51 M4.3 cases are an authored regression set, not a field benchmark. M23 requires permissioned real-church testing before production claims.

## Local proof

Python 3.11+ is required. The core runtime is dependency-light. Optional extras are used for QR generation and signed release verification.

```bash
python -m unittest discover -s tests -v
python -m ruach_core.operator_auth --db ./ruach-local.sqlite3 --username operator1 --role operator
python -m ruach_core.server --db ./ruach-local.sqlite3
```

For deployment operations:

```bash
ruach-deploy backup --db ./ruach-local.sqlite3 --out ./ruach-backup.sqlite3
ruach-deploy verify-backup --db ./ruach-backup.sqlite3
ruach-deploy diagnostics --db ./ruach-local.sqlite3 --out ./diagnostics.json
```

## Current boundaries

- **M1–M22 engineering scope:** implemented/tested as described in `docs/ROADMAP.md`.
- **M23 Church Pilot:** required external gate; not yet run.
- **M24 Commercial Platform:** blocked by M23 results and commercial hosting/tenancy/billing decisions.
- SQLite storage is **not encrypted at rest by RUACH itself**. Production deployment must provide approved storage encryption/key management and TLS/identity infrastructure.
- Real English/Kiswahili/code-switch transcription and detection accuracy still requires permissioned field benchmarking.

## Key architecture records

- [Roadmap](docs/ROADMAP.md)
- [M7 Presentation](docs/architecture/M7_PRESENTATION.md)
- [M8 Live Session](docs/architecture/M8_LIVE_SESSION.md)
- [M9 Sermon Archive](docs/architecture/M9_SERMON_ARCHIVE.md)
- [M10 Congregation Live](docs/architecture/M10_CONGREGATION_LIVE.md)
- [M11 Resilience](docs/architecture/M11_RESILIENCE.md)
- [M12 Sermon Intelligence](docs/architecture/M12_SERMON_INTELLIGENCE.md)
- [M13 Communication](docs/architecture/M13_COMMUNICATION.md)
- [M14 Content Intelligence](docs/architecture/M14_CONTENT_INTELLIGENCE.md)
- [M15 Church Memory](docs/architecture/M15_CHURCH_MEMORY.md)
- [M16 Ask RUACH](docs/architecture/M16_ASK_RUACH.md)
- [M17 Knowledge Governance](docs/architecture/M17_KNOWLEDGE_GOVERNANCE.md)
- [M18 Multilingual Intelligence](docs/architecture/M18_MULTILINGUAL_INTELLIGENCE.md)
- [M19 Discipleship](docs/architecture/M19_DISCIPLESHIP.md)
- [M20 Member Workspace](docs/architecture/M20_MEMBER_WORKSPACE.md)
- [M21 Security & Privacy](docs/architecture/M21_SECURITY_PRIVACY.md)
- [M22 Deployment & Updates](docs/architecture/M22_DEPLOYMENT_UPDATES.md)

The executable checkpoint ZIP is the authoritative snapshot for this milestone until the GitHub repository is fully mirrored from that exact archive.
