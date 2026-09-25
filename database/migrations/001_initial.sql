PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS schema_migrations (
    version INTEGER PRIMARY KEY,
    applied_at TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS sessions (
    session_id TEXT PRIMARY KEY,
    started_at TEXT NOT NULL,
    status TEXT NOT NULL CHECK (status IN ('active', 'ended')),
    next_sequence INTEGER NOT NULL DEFAULT 1
);
CREATE TABLE IF NOT EXISTS transcript_segments (
    segment_id TEXT PRIMARY KEY,
    session_id TEXT NOT NULL REFERENCES sessions(session_id),
    start_ms INTEGER NOT NULL CHECK (start_ms >= 0),
    end_ms INTEGER NOT NULL CHECK (end_ms >= start_ms),
    text TEXT NOT NULL,
    languages_json TEXT NOT NULL,
    provider_json TEXT NOT NULL,
    is_final INTEGER NOT NULL CHECK (is_final = 1)
);
CREATE TABLE IF NOT EXISTS scripture_events (
    event_id TEXT PRIMARY KEY,
    session_id TEXT NOT NULL REFERENCES sessions(session_id),
    segment_id TEXT NOT NULL UNIQUE REFERENCES transcript_segments(segment_id),
    reference_json TEXT NOT NULL,
    detection_json TEXT NOT NULL,
    canonical_text_json TEXT NOT NULL,
    operator_status TEXT NOT NULL CHECK (operator_status IN ('pending', 'approved', 'rejected')),
    display_status TEXT NOT NULL CHECK (display_status IN ('not_displayed', 'displayed', 'hidden')),
    created_at TEXT NOT NULL,
    decided_at TEXT,
    displayed_at TEXT
);
CREATE TABLE IF NOT EXISTS event_log (
    event_id TEXT PRIMARY KEY,
    session_id TEXT NOT NULL REFERENCES sessions(session_id),
    sequence INTEGER NOT NULL,
    kind TEXT NOT NULL CHECK (kind IN (
        'session.started', 'transcript.final', 'scripture.candidate',
        'scripture.detected', 'scripture.approved', 'scripture.rejected',
        'scripture.displayed', 'scripture.hidden'
    )),
    occurred_at TEXT NOT NULL,
    payload_json TEXT NOT NULL,
    UNIQUE(session_id, sequence)
);
CREATE INDEX IF NOT EXISTS idx_log_session_sequence ON event_log(session_id, sequence);
CREATE INDEX IF NOT EXISTS idx_scripture_session ON scripture_events(session_id, created_at);
