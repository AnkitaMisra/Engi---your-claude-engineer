# Getting Started — engi

## Prerequisites
- Claude Code CLI: `npm install -g @anthropic-ai/claude-code`
- Claude account (claude.ai) — no API keys needed

## 5-minute setup

```bash
git clone https://github.com/YOUR_USERNAME/engi
cd your-repo
bash ~/engi/setup.sh
nano CLAUDE.md   # fill in your project details
claude           # open Claude Code
```

## First session

```bash
explore this codebase     # map architecture → SCRATCHPAD.md
/review                   # review current changes
/pipeline PRD.md          # full PRD → tech doc pipeline
```

## Command reference

| Command | When to use |
|---------|-------------|
| `explore this codebase` | First session in any repo |
| `/pipeline` | Starting a new feature from a PRD |
| `/review` | Before every PR |
| `/ship` | Before every commit |
| `/test` | When unsure about test coverage |
| `/explain src/file.py` | Unfamiliar code |
| `/debug` | Any non-obvious bug |
| `/scaffold service Foo` | New module from existing patterns |
| `/handoff` | End of every session |
| `/docs` | If docs/README.md gets out of sync |
| `/vulnerability-check` | Security scan + fix PRs |

## Skill reference

| Skill | Trigger phrase |
|-------|---------------|
| `explore-codebase` | "explore this codebase" |
| `architect` | "architect this PRD" |
| `regression` | "run regression on this plan" |
| `tech-doc` | "tech-doc" or `/pipeline` |
| `code-review` | "review this code" |
| `write-tests` | "write tests for src/file.py" |
| `write-docs` | "write docs for src/file.py" |
| `vulnerability-check` | `/vulnerability-check` |

## Optional integrations

Add `.mcp.json` to your repo root:

```json
{
  "mcpServers": {
    "github": { "type": "url", "url": "https://api.githubcopilot.com/mcp/" },
    "gdrive": { "type": "url", "url": "https://drivemcp.googleapis.com/mcp/v1" }
  }
}
```
