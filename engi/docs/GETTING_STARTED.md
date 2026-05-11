# Getting Started — engi

## Prerequisites
- Claude Code CLI: `npm install -g @anthropic-ai/claude-code`
- Claude account (claude.ai) — no API keys needed

## Setup

```bash
git clone https://github.com/AnkitaMisra/Engi---your-claude-engineer.git ~/engi
cd your-repo
bash ~/engi/engi/setup.sh
nano CLAUDE.md   # fill in 5 fields
claude           # open Claude Code
```

## First session

```bash
explore this codebase     # map architecture → SCRATCHPAD.md
/review                   # review current changes
/pipeline PRD.md          # PRD → full tech doc
```

## Command reference

| Command | When to use |
|---------|-------------|
| `explore this codebase` | First session in any repo |
| `/pipeline` | Starting a new feature from a PRD |
| `/review` | Before every PR |
| `/ship` | Before every commit |
| `/test` | Check test coverage gaps |
| `/explain src/file.py` | Unfamiliar code |
| `/debug` | Any non-obvious bug |
| `/scaffold service Foo` | New module from existing patterns |
| `/handoff` | End of every session |
| `/vulnerability-check` | Security scan + fix PRs |

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
