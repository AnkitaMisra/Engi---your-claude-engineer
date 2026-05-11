# Claude Code Engineering Intelligence Template

> Drop this into any Python or TypeScript repo and get an AI-powered engineering assistant in 5 minutes.
> No API keys. No CI setup. No secrets. Just open Claude Code and start.

---

## What this gives you

### 10 AI agents (skills)
| Skill | What it does | Best model |
|-------|-------------|-----------|
| `explore-codebase` | Maps full codebase → `SCRATCHPAD.md` with Mermaid diagrams | Haiku |
| `architect` | Senior architect analysis of a PRD | Opus |
| `regression` | Stress-tests a plan — edge cases + risk register | Sonnet |
| `tech-doc` | Full pipeline: PRD → architect → regression → `TECH_DOC_{feature}.md` | Opus |
| `code-review` | Structured code review — CRITICAL / MAJOR / MINOR format | Sonnet |
| `write-tests` | Generates comprehensive pytest / Jest test files | Sonnet |
| `write-docs` | Generates docstrings and documentation inline | Haiku |
| `debug` | Hypothesis tree in `SCRATCHPAD_DEBUG.md` → root cause → fix | Sonnet/Opus |
| `scaffold` | Reads `SCRATCHPAD.md` to infer patterns → new module + tests | Sonnet |
| `vulnerability-check` | Repo security scan → severity report → GitHub Issues → fix PRs → Slack | Opus |

### 12 slash commands
| Command | What it does |
|---------|-------------|
| `/pipeline` | Full PRD → tech doc pipeline in one command |
| `/review` | Quick code review of current changes |
| `/ship` | Pre-commit checklist — catches common mistakes |
| `/test` | Identifies test coverage gaps |
| `/explain` | Explains any file or function in plain English |
| `/docs` | Regenerates `docs/README.md` index from what's actually there |
| `/debug` | Systematic debugging with an auditable hypothesis tree |
| `/scaffold` | Generate a new service, endpoint, or module from existing patterns |
| `/handoff` | Write end-of-session context to `MEMORY.md` for the next session |
| `/audit` | Quick security audit of current changes (no issues/PR) |
| `/changelog` | Generate a changelog entry from git history |
| `/vulnerability-check` | Full repo security scan + GitHub Issues + fix PRs + Slack |

### Path-specific rules (auto-activate by file type)
| Rule file | Activates for |
|-----------|--------------|
| `python.md` | `**/*.py` |
| `typescript.md` | `**/*.ts`, `**/*.tsx` |
| `tests.md` | `**/test_*.py`, `**/*.test.ts` |
| `api.md` | Route and endpoint files |
| `security.md` | Auth, input handling, crypto, DB query files |

---

## Setup — 5 minutes

### Step 1 — Copy the template into your repo
```bash
git clone https://github.com/YOUR_USERNAME/claude-code-engineering-intelligence
cd your-repo
bash ~/claude-code-engineering-intelligence/setup.sh
```

### Step 2 — Edit CLAUDE.md
Open `CLAUDE.md` and fill in your project details — takes 5 minutes:
```
PROJECT_NAME → your service name (e.g. "My API Service")
WHAT_IT_DOES → one sentence (e.g. "handles user auth and billing")
FRAMEWORK    → FastAPI / Django / Express / NestJS
```

### Step 3 — Open Claude Code
```bash
claude
```

### Step 4 — Try it immediately
```bash
# Map your codebase (first session)
explore this codebase

# Quick review before a commit
/review

# Run the full pipeline on a PRD
/pipeline path/to/PRD.md
```

---

## Session workflow

Start every session by reading `MEMORY.md` (written by the previous `/handoff`):
```
what were we working on?    → Claude reads MEMORY.md and resumes
```

End every session:
```
/handoff                    → writes MEMORY.md with decisions, next steps, open questions
```

This gives every session instant context with zero re-exploration.

---

## The engineering intelligence pipeline

For feature planning — paste a PRD or give a file path:

```
/pipeline PRD.md
```

What happens under the hood:
1. **Architect agent** reads PRD as a senior architect → implementation plan
2. **Regression agent** stress-tests the plan → edge cases + risk register
3. **Tech doc agent** merges both → writes `TECH_DOC_{feature}.md`

All outputs saved to:
- Repo root (quick access)
- `docs/plans/` (organised, timestamped)
- `docs/README.md` (auto-updated index)

---

## Output files

After running the agents, your repo gains:

```
your-repo/
├── CLAUDE.md                          ← your project standards
├── SCRATCHPAD.md                      ← codebase map (from explore)
├── TECH_DOC_{feature}.md              ← technical plan (from /pipeline)
└── docs/
    ├── README.md                      ← auto-generated index
    ├── architecture/
    │   └── SCRATCHPAD.md              ← with Mermaid diagrams
    └── plans/
        └── TECH_DOC_{feature}.md      ← timestamped copies
```

---

## Customising for your project

After setup, open `CLAUDE.md` and add your team's specific:
- Architecture conventions
- Coding standards
- Known gotchas in the codebase
- Service dependencies

The more context in `CLAUDE.md`, the better every agent performs.

---

## Debugging

For any bug that isn't obvious from the error message:

```
/debug AttributeError: 'NoneType' object has no attribute 'user_id'
```

The debug skill:
1. Collects the error + reproduction steps
2. Reads all files named in the stack trace
3. Builds a hypothesis tree in `SCRATCHPAD_DEBUG.md` (auditable, resumable)
4. Eliminates branches with evidence until root cause is CONFIRMED
5. Proposes a minimal fix + regression test

`SCRATCHPAD_DEBUG.md` is preserved after the session — re-open it to continue debugging later.

---

## Scaffolding

Generate a new component that looks like it belongs in the codebase:

```
/scaffold service ReconciliationService
/scaffold endpoint /api/v1/export
/scaffold worker export-worker
```

The scaffold skill reads `SCRATCHPAD.md` and 1–2 existing files of the same type to infer:
naming conventions, base classes, error handling patterns, import style, async usage.

Produces: source file + test file + wiring instructions. No stubs — complete, runnable output.

> Requires `SCRATCHPAD.md` — run `explore this codebase` first if it doesn't exist.

---

## Model routing

Match task weight to model to control cost and speed:

| Task type | Use |
|-----------|-----|
| Single-file lookup, explain one function, quick Q&A | Haiku |
| Code review, write a service, debug, refactor, most tasks | **Sonnet (default)** |
| Full PRD pipeline, system-wide refactor, security audit | Opus |

The routing guide is in `CLAUDE.md` — Claude reads it automatically and picks the right weight.

---

## Security vulnerability scanning

Run an automated security scan across your GitHub repos:

```bash
/vulnerability-check
# or target a specific repo
/vulnerability-check owner/my-service
```

What happens:

1. **Crawl** — parallel agents scan every configured repo for secrets, injection risks, weak crypto, auth gaps, insecure defaults, and known-CVE dependencies
2. **Report** — findings ranked CRITICAL / HIGH / MEDIUM / LOW with file:line references and remediation guidance
3. **Confirm** — you choose which findings to act on (all CRITICAL+HIGH, specific IDs, or report only)
4. **GitHub Issues** — one issue per confirmed finding with severity, snippet, and remediation steps
5. **Fix PRs** — for findings with safe automated fixes: branch → commit → PR opened and linked to the issue
6. **Slack notification** — optional summary posted to your configured channel with issue and PR links

Vulnerability categories scanned:
- Secrets & credentials hardcoded in source
- SQL / shell / path / LDAP injection
- Missing authentication or authorisation checks
- Weak cryptography (MD5, SHA1, static IV, insecure RNG)
- Dependency CVEs (reads `requirements.txt`, `package.json`, `go.mod`, etc.)
- Sensitive data in logs or error responses
- Insecure defaults (debug mode, CORS `*`, missing CSRF / rate limiting)

> Fix PRs are always surgical — one vulnerability per PR, minimal diff. Complex remediations that cannot be safely automated are flagged in GitHub Issues with "Manual remediation required."

---

## Google Doc support

The pipeline agents accept Google Doc URLs directly if you add the Google Drive MCP:

```
/pipeline https://docs.google.com/document/d/YOUR_DOC_ID/edit
```

Add this to `.mcp.json` in your repo to enable:
```json
{
  "mcpServers": {
    "gdrive": {
      "type": "url",
      "url": "https://drivemcp.googleapis.com/mcp/v1"
    }
  }
}
```

---

## Optional integrations

The `vulnerability-check` skill supports optional integrations for richer workflows:

| Integration | What it adds | How to enable |
|-------------|-------------|---------------|
| **Slack** | Post scan summary to a channel | Add Slack MCP to `.mcp.json` |
| **Jira** | Create bug tickets for findings | Add Atlassian MCP to `.mcp.json` |
| **GitHub MCP** | Richer repo access + PR creation | Add GitHub MCP to `.mcp.json` |

If no integrations are configured, the skill runs in report-only mode — findings are printed to the session.

---

## Contributing

Found a bug or want to improve a skill? Contributions are welcome!

1. Fork this repo
2. Create a branch: `git checkout -b feat/improve-scaffold-skill`
3. Make your changes — each skill is a single markdown file in `.claude/skills/`
4. Open a pull request with a description of what you changed and why

Each skill is a single markdown file — easy to read, easy to modify.

---

*Built on Anthropic Claude · Requires Claude Code CLI*
*`npm install -g @anthropic-ai/claude-code`*
