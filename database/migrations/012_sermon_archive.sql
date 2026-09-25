CREATE TABLE IF NOT EXISTS sermon_archives (
    archive_id TEXT PRIMARY KEY,
    session_id TEXT NOT NULL UNIQUE REFERENCES sessions(session_id),
    archive_version INTEGER NOT NULL CHECK (archive_version = 1),
    manifest_json TEXT NOT NULL,
    sha256 TEXT NOT NULL CHECK (length(sha256) = 64),
    sealed_at TEXT NOT NULL
);

CREATE TRIGGER IF NOT EXISTS sermon_archives_require_ended
BEFORE INSERT ON sermon_archives
BEGIN
    SELECT CASE WHEN NOT EXISTS (
        SELECT 1 FROM live_session_state
        WHERE session_id = NEW.session_id AND phase = 'ended'
    ) THEN RAISE(ABORT, 'archive requires ended session') END;
END;

CREATE TRIGGER IF NOT EXISTS sermon_archives_no_update
BEFORE UPDATE ON sermon_archives
BEGIN
    SELECT RAISE(ABORT, 'sealed archive is immutable');
END;

CREATE TRIGGER IF NOT EXISTS sermon_archives_no_delete
BEFORE DELETE ON sermon_archives
BEGIN
    SELECT RAISE(ABORT, 'sealed archive is immutable');
END;
