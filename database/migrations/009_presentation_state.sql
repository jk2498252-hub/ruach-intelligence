CREATE TABLE IF NOT EXISTS presentation_state (
    slot_id INTEGER PRIMARY KEY CHECK (slot_id = 1),
    revision INTEGER NOT NULL DEFAULT 0 CHECK (revision >= 0),
    changed_at TEXT NOT NULL
);
INSERT OR IGNORE INTO presentation_state(slot_id, revision, changed_at)
VALUES (1, 0, strftime('%Y-%m-%dT%H:%M:%fZ','now'));
