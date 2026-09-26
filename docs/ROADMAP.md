# RUACH Intelligence roadmap

| Module | Status |
| --- | --- |
| M1 Structural Core | DONE |
| M2 Scripture Data Layer | CORE DONE: ENGWEBP + SWHONEN; additional editions require individual rights/source review |
| M3 Audio & Transcription | CORE DONE; field accuracy remains M23 evidence |
| M4 Scripture Detection | CORE DONE; real-sermon performance remains M23 evidence |
| M5 Evaluation Laboratory | DONE as evaluation tooling; field evidence still requires permissioned recordings |
| M6 Operator Console | DONE for local proof |
| M7 Presentation | DONE |
| M8 Live Session | DONE |
| M9 Sermon Archive | DONE |
| M10 Congregation Live | DONE |
| M11 Resilience | DONE |
| M12 Sermon Intelligence | DONE, human-review gated |
| M13 Communication | DONE, human-review gated; no autonomous publication |
| M14 Content Intelligence | DONE, reviewed suggestions only |
| M15 Church Memory | DONE, approved-memory only |
| M16 Ask RUACH | DONE, grounded/read-only |
| M17 Knowledge Governance | DONE |
| M18 Multilingual Intelligence | DONE for explicit EN/SW metadata/code-switch-aware retrieval; field performance remains M23 |
| M19 Discipleship | DONE, human-review gated |
| M20 Member Workspace | DONE in privacy-conservative consent-first scope |
| M21 Security & Privacy | DONE for local proof controls; plaintext SQLite/TLS/hosted identity limitations remain |
| M22 Deployment & Updates | DONE for offline backup/restore/diagnostics/hash verification |
| M23 Church Pilots | **READY FOR FIELD PILOT — NOT YET PASSED** |
| M24 Commercial Platform | **ARCHITECTURE READY — NOT DEPLOYED** |

## Remaining real-world gates

1. Conduct the permissioned M23 pilot using the frozen 0.4.0rc1 release and predeclared thresholds.
2. Resolve every critical pilot incident and repeat affected services/tests as required.
3. Only after M23 passes, implement and independently review M24 tenant isolation, hosted identity/MFA, TLS/encryption/secrets, billing/entitlements and production operations.
