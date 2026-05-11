# CLAUDE.md
# Project-level config — edit the ALL_CAPS placeholders for your project
# This file is read by Claude Code on every session in this repo

## Project overview
PROJECT_NAME is a SERVICE_TYPE service that WHAT_IT_DOES.
Main entry point: ENTRY_POINT (e.g. src/main.py, src/index.ts, app/server.py)
Framework: FRAMEWORK (e.g. FastAPI, NestJS, Django, Express)
Team: TEAM_NAME

## Tech stack
- Language: LANGUAGE (Python 3.11+ / TypeScript 5+)
- Framework: FRAMEWORK
- Database: DATABASE (e.g. PostgreSQL, DynamoDB)
- Message queue: QUEUE (e.g. Kafka, SQS, none)
- Key dependencies: LIST_KEY_LIBRARIES

## Architecture conventions
- DESCRIBE_YOUR_ARCHITECTURE (e.g. "Layered: routes → services → repositories → models")
- DESCRIBE_DATA_FLOW (e.g. "All DB access through repository pattern — no direct ORM in services")
- DESCRIBE_ERROR_HANDLING (e.g. "All errors bubble up as typed exceptions, caught at route level")

## Python standards (remove if TypeScript only)
- Python 3.11+ — use match/case, str | None union types
- Type hints required on ALL public functions
- Pydantic for all data models — no raw dicts
- async/await for all I/O — httpx not requests
- structlog for logging — never print() in production
- Google-style docstrings on all public functions

## TypeScript standards (remove if Python only)
- TypeScript strict mode — no any types
- Zod for runtime validation of external data
- Async/await — no raw Promise chains
- Named exports — no default exports
- JSDoc on all public functions and classes

## Testing
- pytest / Jest for all tests — no unittest
- Mock ALL external calls — no live API calls in tests
- Test file mirrors source file path
- Test naming: test_{what}_{when}_{expected}

## Git conventions
- Commit format: type(scope): description
  Types: feat, fix, docs, refactor, test, chore
- PR description must explain WHY not just what

## Model routing

Match task weight to model — default to Sonnet for everything unless noted below.

| Model | When to use |
|-------|-------------|
| Haiku (fastest) | Single-file lookups, grep searches, quick Q&A, generating a single test, explaining one function |
| Sonnet (default) | Code review, writing a service/endpoint, debugging, refactoring, writing docs, most day-to-day tasks |
| Opus (most capable) | Full PRD → architect pipeline, system-wide refactors, security audit, anything touching 5+ files or requiring deep reasoning |

How to invoke a specific model:

```
claude --model claude-haiku-4-5-20251001
claude --model claude-sonnet-4-6        # default
claude --model claude-opus-4-7
```

Skills that always use Opus: `architect`, `tech-doc`, `vulnerability-check`, `debug` (complex bugs)
Skills that use Haiku by default: `explore-codebase`, `write-docs`

## Always do
- Check for existing patterns before introducing new ones
- Flag security concerns immediately
- If task requires 3+ files to change — stop and confirm approach first
- Read MEMORY.md at the start of each session if it exists

## Never do
- Never modify .env or secrets files
- Never delete tests without explicit instruction
- Never hardcode URLs, keys, or environment-specific values
- Never commit console.log / print() statements
