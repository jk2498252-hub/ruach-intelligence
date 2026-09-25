CREATE TABLE IF NOT EXISTS sermon_intelligence_model_runs (
    run_id TEXT PRIMARY KEY,
    draft_id TEXT NOT NULL UNIQUE REFERENCES sermon_intelligence_drafts(draft_id),
    archive_id TEXT NOT NULL REFERENCES sermon_archives(archive_id),
    archive_sha256 TEXT NOT NULL CHECK (length(archive_sha256)=64),
    provider TEXT NOT NULL,
    model TEXT NOT NULL,
    input_sha256 TEXT NOT NULL CHECK (length(input_sha256)=64),
    response_sha256 TEXT NOT NULL CHECK (length(response_sha256)=64),
    requested_by TEXT NOT NULL REFERENCES operators(operator_id),
    created_at TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_intelligence_model_runs_archive
ON sermon_intelligence_model_runs(archive_id, created_at DESC, run_id DESC);

CREATE TRIGGER IF NOT EXISTS intelligence_model_runs_no_update
BEFORE UPDATE ON sermon_intelligence_model_runs
BEGIN
    SELECT RAISE(ABORT, 'intelligence model-run provenance is immutable');
END;
CREATE TRIGGER IF NOT EXISTS intelligence_model_runs_no_delete
BEFORE DELETE ON sermon_intelligence_model_runs
BEGIN
    SELECT RAISE(ABORT, 'intelligence model-run provenance is retained for audit');
END;
