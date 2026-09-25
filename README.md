# RUACH Intelligence

RUACH carries a church service from the pulpit to the screen, congregation, week, and church memory. **M1 Structural Core**, **M2.3 two complete Bible editions**, **M3.3 optional transcription**, **M4.3 detector regression tests**, **M5.1 an evaluation harness**, and **M6.3b local operator sign-in, owned sessions and explicit projector routing** and **M7 presentation** is implemented through projector state, safe presets, authenticated private preview, and clean broadcast output. **M8 Live Session Engine** is also implemented, including the immutable ended-service audit boundary. The product roadmap is in [docs/ROADMAP.md](docs/ROADMAP.md).

## Run the local proof

Python 3.11+ and no third-party packages are required for this foundation slice.

```bash
python -m unittest discover -s tests -v
python -m ruach_core.demo
python -m ruach_core.full_import --db ./ruach-local.sqlite3 --translation ALL
python -m ruach_core.lookup --db ./ruach-local.sqlite3 --translation SWHONEN --book GEN --chapter 1 --verse 1
python -m ruach_core.operator_auth --db ./ruach-local.sqlite3 --username operator1 --role operator
python -m ruach_core.server --db ./ruach-local.sqlite3
python -m ruach_core.audio_cli --db ./ruach-local.sqlite3 --wav ./sample.wav --transcript ./verbatim.txt --translation SWHONEN --language sw
python -m ruach_core.transcript_eval ./permissioned_samples.jsonl
python -m ruach_core.detection_eval data/evaluation/m4_3_labeled_utterances.jsonl
python -m ruach_core.field_eval data/evaluation/m5_example_manifest.json
```

Before starting the server, create a local account using `python -m ruach_core.operator_auth --db ruach-local.sqlite3 --username operator1 --role operator` (the password is prompted, at least 12 characters). Then open `http://127.0.0.1:8765/operator` and `http://127.0.0.1:8765/display` in separate windows.

The operator page restores the latest local session and lists pending, approved-but-not-shown, and held proposals after refresh or server restart. It can dismiss held proposals with a ledger entry and correct a pending single-verse proposal to a verified verse before approval. Each correction records the earlier and new references and hashes in the append-only ledger. Operator action labels come from signed-in local accounts.

The bundled publisher archives import ENGWEBP and Biblica Open Kiswahili Contemporary Version (SWHONEN), each with its own 66-book source, rights record and attribution. The M4.1 parser recognizes explicit single-verse references using publisher book headings from all 66 books in English and Kiswahili. A chapter or range becomes a held proposal; the operator can select one verse within it, which still requires a second approval before display.

The 51 authored M4.3 cases are a regression set, not a field accuracy measure. M5.1 adds an aggregate-only evaluation harness for later permissioned, human-labeled recordings. Optional OpenAI file transcription is available when `OPENAI_API_KEY` is set; audio leaves the local computer only when the operator explicitly chooses that service.

Only bind this proof server to loopback. The database can contain audio bytes and sermon text; do not use real sermons or personal information with this development proof. Additional translations require separate rights and source review.

## Current checkpoint

Baseline imported to GitHub from the saved **RUACH_Intelligence_M6_3b** checkpoint on 2026-09-25.

Local verification before import:

- **71 tests passed**
- **357 detector subtests remain passing**
- Next implementation bite: **M9.1 deterministic sermon archive record**

## Contracts and decisions

- [Canonical contracts](docs/architecture/CONTRACTS.md)
- [Architecture and boundaries](docs/architecture/M1.md)
- [Evidence register](docs/evidence/REGISTER.md)
- [Translation rights policy](docs/licensing/TRANSLATIONS.md)
- [Privacy baseline](docs/privacy/BASELINE.md)
- [M7 presentation engine](docs/architecture/M7_PRESENTATION.md)
- [M8.1 live session lifecycle](docs/architecture/M8_LIVE_SESSION.md)
- [Roadmap](docs/ROADMAP.md)

The `ruach_core` package is the source of truth. Nothing in this repository is asserted to be production ready.
