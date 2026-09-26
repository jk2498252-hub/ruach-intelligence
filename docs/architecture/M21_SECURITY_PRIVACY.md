# M21 Security & Privacy

Implemented and tested: scrypt password hashing, hashed bearer/member tokens, 8-hour operator sessions, persistent login throttling using hashed principals, password rotation with session revocation, self-session revocation, member export/erasure, and content-free privacy audit metadata.

Explicit limitations: SQLite is not encrypted at rest; the loopback proof does not terminate production TLS; there is no hosted SSO/MFA/secrets-vault layer. Those remain hosted-production requirements.
