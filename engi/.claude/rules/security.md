# Security rules
# Applied whenever touching auth, input handling, crypto, DB queries, or external data

## Input & injection
- Validate ALL external input at the boundary — never trust request data inside services
- Use parameterised queries always — never build SQL with string concatenation or f-strings
- Sanitise file paths from user input — no `os.path.join(base, user_input)` without validation
- Never pass user-controlled strings to `subprocess`, `os.system`, `eval`, or `exec`
- Escape output for the target context (HTML, JSON, shell) — never assume safe

## Authentication & authorisation
- Every non-public endpoint must have an auth dependency/middleware — no inline auth logic
- Check authorisation at the service layer too — don't rely on the route guard alone
- Never roll custom auth — use the established auth library in this codebase
- JWT: verify signature + expiry + audience — never accept `alg: none`
- Session tokens: HttpOnly + Secure cookies only — never localStorage

## Cryptography
- Passwords: bcrypt, argon2, or scrypt only — never MD5, SHA1, or SHA256 for passwords
- Encryption: AES-256-GCM or ChaCha20-Poly1305 — never DES, RC4, or ECB mode
- Random values for security: `secrets` module (Python) or `crypto.randomBytes` (Node) — never `random`
- Never hardcode IV, salt, or key — generate fresh per operation
- TLS: never set `verify=False` or `ssl._create_unverified_context`

## Secrets & config
- Secrets come from environment variables or a secrets manager — never from source files
- Never log secrets, tokens, passwords, or full PII — mask before logging
- `.env` files are never committed — `.env.example` with placeholder values only
- Rotate any secret that appears in a commit immediately

## Dependency hygiene
- Pin all dependencies to exact versions in production
- Check new dependencies for known CVEs before adding
- Keep dependencies up to date — unpatched deps are the most common vuln class

## Error handling & information disclosure
- Production error responses: generic message only — no stack traces, no internal paths
- Log full error internally via structlog — never expose to the client
- 404 and 403 responses must not reveal whether a resource exists (use consistent responses)

## Code review gate
When reviewing any PR that touches:
- Auth or session handling → flag for security review before merge
- Input parsing or query building → verify parameterisation
- Cryptographic operations → verify algorithm and key handling
- New dependencies → check for CVEs

Flag as CRITICAL in code-review if any rule above is violated.
