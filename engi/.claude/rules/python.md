---
globs: ["**/*.py"]
description: Python coding standards — activates only when editing .py files
---

# Python rules

- Python 3.11+ features preferred: match/case, str | None, tomllib
- All public functions require type hints — no exceptions
- Use Pydantic BaseModel for all structured data — no TypedDict or raw dicts
- async/await for all I/O operations — never use requests, always httpx
- Logging via structlog — never print() in production code
- Google-style docstrings: Args, Returns, Raises sections
- Import order: stdlib → third-party → local (isort enforced)
- f-strings only — no % formatting or .format()
- No mutable default arguments — use None and set in body
- Context managers for all file and connection handling
