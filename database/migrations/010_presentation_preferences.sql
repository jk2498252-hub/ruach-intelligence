CREATE TABLE IF NOT EXISTS presentation_preferences (
    slot_id INTEGER PRIMARY KEY CHECK (slot_id = 1),
    theme TEXT NOT NULL CHECK (theme IN ('dark', 'light', 'high_contrast')),
    layout TEXT NOT NULL CHECK (layout IN ('centered', 'lower_third')),
    updated_at TEXT NOT NULL
);
INSERT OR IGNORE INTO presentation_preferences(slot_id, theme, layout, updated_at)
VALUES (1, 'dark', 'centered', strftime('%Y-%m-%dT%H:%M:%fZ','now'));

CREATE TABLE event_log_new (
    event_id TEXT PRIMARY KEY,
    session_id TEXT NOT NULL REFERENCES sessions(session_id),
    sequence INTEGER NOT NULL,
    kind TEXT NOT NULL CHECK (kind IN (
        'session.started', 'session.assigned', 'projector.selected', 'projector.released', 'presentation.changed',
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
