"""Provider-neutral communication draft adapter.

Consumes only an already-approved M12 intelligence payload. It can propose outward-facing
copy but cannot approve or publish it.
"""

import json

MAX_COMMUNICATION_RESPONSE_CHARS = 20_000

def _clean_label(value, field, maximum=128):
    if not isinstance(value, str) or not 1 <= len(value.strip()) <= maximum:
        raise ValueError(f"invalid communication {field}")
    clean=value.strip()
    if any(ord(c)<32 for c in clean):
        raise ValueError(f"invalid communication {field}")
    return clean

class CommunicationDraftAdapter:
    def __init__(self, provider, model, generate):
        self.provider=_clean_label(provider,"provider",64)
        self.model=_clean_label(model,"model",128)
        if not callable(generate):
            raise ValueError("communication generator must be callable")
        self._generate=generate
    @property
    def source_label(self):
        return f"{self.provider}/{self.model}"[:128]
    def generate(self, source):
        try:
            value=self._generate(source)
        except Exception as exc:
            raise ValueError("communication provider unavailable") from exc
        if not isinstance(value,dict):
            raise ValueError("invalid communication provider response")
        encoded=json.dumps(value,ensure_ascii=False,sort_keys=True,separators=(",",":"))
        if len(encoded)>MAX_COMMUNICATION_RESPONSE_CHARS:
            raise ValueError("communication provider response too large")
        return value

def communication_model_source(intelligence_draft, channel):
    if channel not in ("whatsapp_recap","video_description"):
        raise ValueError("invalid communication channel")
    if not isinstance(intelligence_draft,dict) or intelligence_draft.get("status")!="approved":
        raise ValueError("communication requires approved intelligence draft")
    payload=intelligence_draft.get("payload")
    if not isinstance(payload,dict):
        raise ValueError("invalid intelligence source")
    return {
        "schema":"ruach.communication.source.v1",
        "channel":channel,
        "intelligence_payload_sha256":intelligence_draft.get("payload_sha256"),
        "approved_intelligence":{
            "title":payload.get("title",""),
            "summary":payload.get("summary",""),
            "points":payload.get("points",[]),
            "scripture_event_ids":payload.get("scripture_event_ids",[]),
        },
        "task":{"output_fields":["body"],"rules":[
            "Use only the approved intelligence supplied here.",
            "Do not invent sermon claims, scripture references, dates, people, links, or calls to action.",
            "Return outward-facing copy as a draft for separate human review.",
            "Do not claim the text is approved, published, sent, or posted."
        ]}
    }
