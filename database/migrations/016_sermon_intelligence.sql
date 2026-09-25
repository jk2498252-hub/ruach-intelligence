CREATE TABLE IF NOT EXISTS sermon_intelligence_drafts (
    draft_id TEXT PRIMARY KEY,
    archive_id TEXT NOT NULL REFERENCES sermon_archives(archive_id),
    archive_sha256 TEXT NOT NULL CHECK (length(archive_sha256)=64),
    draft_version INTEGER NOT NULL CHECK (draft_version=1),
    payload_json TEXT NOT NULL,
    payload_sha256 TEXT NOT NULL CHECK (length(payload_sha256)=64),
    source_kind TEXT NOT NULL CHECK (source_kind IN ('human_authored','model_draft')),
    source_label TEXT NOT NULL,
    status TEXT NOT NULL CHECK (status IN ('draft','approved','rejected')),
    created_by TEXT NOT NULL REFERENCES operators(operator_id),
    created_at TEXT NOT NULL,
    decided_by TEXT REFERENCES operators(operator_id),
    decided_at TEXT
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_intelligence_one_approved_per_archive
ON sermon_intelligence_drafts(archive_id) WHERE status='approved';
CREATE INDEX IF NOT EXISTS idx_intelligence_archive_created
ON sermon_intelligence_drafts(archive_id, created_at DESC, draft_id DESC);

CREATE TABLE IF NOT EXISTS sermon_intelligence_audit (
    audit_id TEXT PRIMARY KEY,
    draft_id TEXT NOT NULL REFERENCES sermon_intelligence_drafts(draft_id),
    action TEXT NOT NULL CHECK (action IN ('draft_created','approved','rejected')),
    actor_id TEXT NOT NULL REFERENCES operators(operator_id),
    occurred_at TEXT NOT NULL,
    metadata_json TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_intelligence_audit_draft
ON sermon_intelligence_audit(draft_id, occurred_at, audit_id);
