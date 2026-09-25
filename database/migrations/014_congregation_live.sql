CREATE TABLE IF NOT EXISTS congregation_shares (
    session_id TEXT PRIMARY KEY REFERENCES sessions(session_id) ON DELETE CASCADE,
    token_hash TEXT NOT NULL UNIQUE CHECK (length(token_hash)=64),
    enabled_at TEXT NOT NULL,
    disabled_at TEXT
);
CREATE INDEX IF NOT EXISTS idx_congregation_token_hash ON congregation_shares(token_hash);

CREATE TABLE event_log_new (
    event_id TEXT PRIMARY KEY,
    session_id TEXT NOT NULL REFERENCES sessions(session_id),
    sequence INTEGER NOT NULL,
    kind TEXT NOT NULL CHECK (kind IN (
        'session.started', 'session.live_started', 'session.ended', 'session.assigned',
        'projector.selected', 'projector.released', 'presentation.changed',
        'congregation.share_enabled', 'congregation.share_disabled',
        'audio.received', 'transcript.final', 'scripture.candidate', 'scripture.candidate_dismissed',
        'scripture.detected', 'scripture.corrected', 'scripture.approved', 'scripture.rejected',
        'scripture.displayed', 'scripture.hidden'
    )),
    occurred_at TEXT NOT NULL,
    payload_json TEXT NOT NULL,
    UNIQUE(session_id, sequence)
);
INSERT INTO event_log_new SELECT * FROM event_log;
DROP TABLE event_log;
ALTER TABLE event_log_new RENAME TO event_log;
CREATE INDEX idx_log_session_sequence ON event_log(session_id, sequence);
