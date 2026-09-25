CREATE TABLE IF NOT EXISTS communication_model_runs (
    run_id TEXT PRIMARY KEY,
    communication_id TEXT NOT NULL UNIQUE REFERENCES communication_drafts(communication_id),
    intelligence_payload_sha256 TEXT NOT NULL CHECK (length(intelligence_payload_sha256)=64),
    provider TEXT NOT NULL,
    model TEXT NOT NULL,
    input_sha256 TEXT NOT NULL CHECK (length(input_sha256)=64),
    response_sha256 TEXT NOT NULL CHECK (length(response_sha256)=64),
    requested_by TEXT NOT NULL REFERENCES operators(operator_id),
    created_at TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_communication_model_runs_draft
ON communication_model_runs(communication_id, created_at DESC);
CREATE TRIGGER IF NOT EXISTS communication_model_runs_no_update
BEFORE UPDATE ON communication_model_runs
BEGIN
    SELECT RAISE(ABORT, 'communication model-run provenance is immutable');
END;
CREATE TRIGGER IF NOT EXISTS communication_model_runs_no_delete
BEFORE DELETE ON communication_model_runs
BEGIN
    SELECT RAISE(ABORT, 'communication model-run provenance is retained for audit');
END;
