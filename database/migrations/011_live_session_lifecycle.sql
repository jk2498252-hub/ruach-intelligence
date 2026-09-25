CREATE TABLE IF NOT EXISTS live_session_state (
    session_id TEXT PRIMARY KEY REFERENCES sessions(session_id),
    phase TEXT NOT NULL CHECK (phase IN ('prepared', 'live', 'ended')),
    live_started_at TEXT,
    ended_at TEXT,
    updated_at TEXT NOT NULL
);

INSERT OR IGNORE INTO live_session_state(session_id, phase, live_started_at, ended_at, updated_at)
SELECT session_id,
       CASE WHEN status='ended' THEN 'ended' ELSE 'live' END,
       CASE WHEN status='active' THEN started_at ELSE NULL END,
       CASE WHEN status='ended' THEN started_at ELSE NULL END,
       started_at
FROM sessions;

CREATE TABLE event_log_new (
    event_id TEXT PRIMARY KEY,
    session_id TEXT NOT NULL REFERENCES sessions(session_id),
    sequence INTEGER NOT NULL,
    kind TEXT NOT NULL CHECK (kind IN (
        'session.started', 'session.live_started', 'session.ended', 'session.assigned',
        'projector.selected', 'projector.released', 'presentation.changed',
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
