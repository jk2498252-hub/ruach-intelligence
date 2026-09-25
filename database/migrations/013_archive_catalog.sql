CREATE TABLE IF NOT EXISTS sermon_archive_catalog (
    archive_id TEXT PRIMARY KEY REFERENCES sermon_archives(archive_id),
    session_id TEXT NOT NULL UNIQUE REFERENCES sessions(session_id),
    archive_version INTEGER NOT NULL CHECK (archive_version = 1),
    owner_operator_id TEXT REFERENCES operators(operator_id),
    owner_username TEXT,
    started_at TEXT NOT NULL,
    live_started_at TEXT,
    ended_at TEXT NOT NULL,
    transcript_count INTEGER NOT NULL CHECK (transcript_count >= 0),
    audio_chunk_count INTEGER NOT NULL CHECK (audio_chunk_count >= 0),
    scripture_event_count INTEGER NOT NULL CHECK (scripture_event_count >= 0),
    ledger_event_count INTEGER NOT NULL CHECK (ledger_event_count >= 0),
    sha256 TEXT NOT NULL CHECK (length(sha256) = 64),
    sealed_at TEXT NOT NULL
);

INSERT OR IGNORE INTO sermon_archive_catalog(
    archive_id,session_id,archive_version,owner_operator_id,owner_username,
    started_at,live_started_at,ended_at,transcript_count,audio_chunk_count,
    scripture_event_count,ledger_event_count,sha256,sealed_at
)
SELECT archive_id,session_id,archive_version,
       json_extract(manifest_json,'$.session.owner_operator_id'),
       json_extract(manifest_json,'$.session.owner_username'),
       json_extract(manifest_json,'$.session.started_at'),
       json_extract(manifest_json,'$.session.live_started_at'),
       json_extract(manifest_json,'$.session.ended_at'),
       COALESCE(json_array_length(manifest_json,'$.transcript_segments'),0),
       COALESCE(json_array_length(manifest_json,'$.audio_chunks'),0),
       COALESCE(json_array_length(manifest_json,'$.scripture_events'),0),
       COALESCE(json_array_length(manifest_json,'$.ledger'),0),
       sha256,sealed_at
FROM sermon_archives;

CREATE INDEX IF NOT EXISTS idx_archive_catalog_owner_sealed
ON sermon_archive_catalog(owner_operator_id, sealed_at DESC, archive_id DESC);
CREATE INDEX IF NOT EXISTS idx_archive_catalog_sealed
ON sermon_archive_catalog(sealed_at DESC, archive_id DESC);

CREATE TRIGGER IF NOT EXISTS sermon_archive_catalog_no_update
BEFORE UPDATE ON sermon_archive_catalog
BEGIN
    SELECT RAISE(ABORT, 'archive catalog metadata is immutable');
END;

CREATE TRIGGER IF NOT EXISTS sermon_archive_catalog_no_delete
BEFORE DELETE ON sermon_archive_catalog
BEGIN
    SELECT RAISE(ABORT, 'archive catalog metadata is immutable');
END;
