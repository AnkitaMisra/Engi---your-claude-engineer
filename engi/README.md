# engi — your Claude engineer

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
| `/docs` | Regenerates `docs/README.md` index |
| `/debug` | Systematic debugging with an auditable hypothesis tree |
| `/scaffold` | Generate a new service, endpoint, or module from existing patterns |
| `/handoff` | Write end-of-session context to `MEMORY.md` for the next session |
| `/audit` | Quick security audit of current changes |
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

```bash
# 1. Clone engi
git clone https://github.com/YOUR_USERNAME/engi

# 2. From your repo root — run setup
cd your-repo
bash ~/engi/setup.sh

# 3. Fill in your project details
nano CLAUDE.md

# 4. Open Claude Code
claude
```

---

## The shift: dev chat → structured process

**Before engi** — you paste a question, get a wall of text, copy pieces manually, start from zero next session.

**After engi:**

```bash
explore this codebase     # maps architecture → SCRATCHPAD.md
/pipeline PRD.md          # arch plan + risk register in <5 min
/vulnerability-check      # scan → issues → fix PRs, same session
/handoff                  # MEMORY.md so next session picks up instantly
```

---

## The engineering intelligence pipeline

```
PRD → Architect → Regression → TECH_DOC_{feature}.md
```

1. **Architect** — implementation plan, trade-offs, phased rollout
2. **Regression** — edge cases, risk register, historical hotspots
3. **Tech doc** — reconciles both, every conflict explicitly resolved

---

## Session memory

`/handoff` writes `MEMORY.md` at the end of every session — decisions, files changed, next steps. Next session reads it and picks up instantly. Zero lost context.

---

## Model routing

| Task | Model |
|------|-------|
| Single-file lookup, quick Q&A | Haiku |
| Code review, write a service, debug | **Sonnet (default)** |
| Full PRD pipeline, security audit | Opus |

---

## Optional integrations

Add `.mcp.json` to your repo:

```json
{
  "mcpServers": {
    "github": { "type": "url", "url": "https://api.githubcopilot.com/mcp/" },
    "gdrive": { "type": "url", "url": "https://drivemcp.googleapis.com/mcp/v1" }
  }
}
```

---

## Contributing

Each skill and command is a single markdown file — easy to read and modify.

1. Fork this repo
2. `git checkout -b feat/my-improvement`
3. Edit `.claude/skills/*.md` or `.claude/commands/*.md`
4. Open a PR

---

*Built on Anthropic Claude · Requires Claude Code CLI*
*`npm install -g @anthropic-ai/claude-code`*
