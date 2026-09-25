# Pinned Bible source archives

The tested local RUACH M6.3b/M7.1 checkpoint contains two pinned publisher archives:

- `engwebp_usfx.zip` — World English Bible 66-book protocanon source
- `swhonen_usfx.zip` — Biblica Open Kiswahili Contemporary Version source

These binary archives are retained in the verified local checkpoint and are intentionally not reconstructed or rewritten. The connected GitHub writer used for the initial import can create UTF-8 repository files but does not provide a direct binary-file transfer path from the saved checkpoint. Do not substitute another mirror merely to make the repository self-contained.

The exact expected archive hashes and source metadata are defined in `ruach_core/editions.py` and the licensing/evidence documents. Until the original bytes are uploaded through a binary-capable Git path, full-import tests that require the archives should be run from the saved checkpoint.
