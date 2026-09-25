CREATE TABLE IF NOT EXISTS communication_drafts (
    communication_id TEXT PRIMARY KEY,
    intelligence_draft_id TEXT NOT NULL REFERENCES sermon_intelligence_drafts(draft_id),
    intelligence_payload_sha256 TEXT NOT NULL CHECK (length(intelligence_payload_sha256)=64),
    channel TEXT NOT NULL CHECK (channel IN ('whatsapp_recap','video_description')),
    body TEXT NOT NULL,
    body_sha256 TEXT NOT NULL CHECK (length(body_sha256)=64),
    status TEXT NOT NULL CHECK (status IN ('draft','approved','rejected')),
    created_by TEXT NOT NULL REFERENCES operators(operator_id),
    created_at TEXT NOT NULL,
    decided_by TEXT REFERENCES operators(operator_id),
    decided_at TEXT
);
CREATE INDEX IF NOT EXISTS idx_communication_intelligence_created
ON communication_drafts(intelligence_draft_id, created_at DESC, communication_id DESC);
CREATE UNIQUE INDEX IF NOT EXISTS idx_communication_one_approved_channel
ON communication_drafts(intelligence_draft_id, channel) WHERE status='approved';

CREATE TABLE IF NOT EXISTS communication_audit (
    audit_id TEXT PRIMARY KEY,
    communication_id TEXT NOT NULL REFERENCES communication_drafts(communication_id),
    action TEXT NOT NULL CHECK (action IN ('draft_created','approved','rejected')),
    actor_id TEXT NOT NULL REFERENCES operators(operator_id),
    occurred_at TEXT NOT NULL,
    metadata_json TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_communication_audit
ON communication_audit(communication_id, occurred_at, audit_id);

CREATE TRIGGER IF NOT EXISTS communication_content_immutable
BEFORE UPDATE ON communication_drafts
WHEN OLD.intelligence_draft_id != NEW.intelligence_draft_id
  OR OLD.intelligence_payload_sha256 != NEW.intelligence_payload_sha256
  OR OLD.channel != NEW.channel
  OR OLD.body != NEW.body
  OR OLD.body_sha256 != NEW.body_sha256
  OR OLD.created_by != NEW.created_by
  OR OLD.created_at != NEW.created_at
BEGIN
    SELECT RAISE(ABORT, 'communication draft content is immutable; create a new draft');
END;
CREATE TRIGGER IF NOT EXISTS communication_no_delete
BEFORE DELETE ON communication_drafts
BEGIN
    SELECT RAISE(ABORT, 'communication drafts are retained for audit');
END;
CREATE TRIGGER IF NOT EXISTS communication_audit_no_update
BEFORE UPDATE ON communication_audit
BEGIN
    SELECT RAISE(ABORT, 'communication audit is append-only');
END;
CREATE TRIGGER IF NOT EXISTS communication_audit_no_delete
BEFORE DELETE ON communication_audit
BEGIN
    SELECT RAISE(ABORT, 'communication audit is append-only');
END;
