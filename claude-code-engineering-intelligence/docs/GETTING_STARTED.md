# Getting Started — Claude Code Engineering Intelligence

## Prerequisites
- Claude Code CLI installed: `npm install -g @anthropic-ai/claude-code`
- Claude account (claude.ai)
- No API keys needed — uses your Claude login

## 5-minute setup

```bash
# 1. Clone the template
git clone https://github.com/YOUR_USERNAME/claude-code-engineering-intelligence

# 2. From your repo root — run the setup script
cd your-repo
bash ~/claude-code-engineering-intelligence/setup.sh

# 3. Edit CLAUDE.md with your project details (5 min)
nano CLAUDE.md  # or open in any editor

# 4. Open Claude Code
claude
```

## Your first session

### Map the codebase (do this first in any new repo)
```
explore this codebase
```
Produces `SCRATCHPAD.md` with:
- Architecture map
- Workflow graph (Mermaid)
- System architecture diagram (Mermaid)
- Where to start for common tasks
- Gotchas and non-obvious patterns

Both diagrams render on GitHub automatically.

### Quick code review
```
/review
```

### Pre-commit check
```
/ship
```

### Full pipeline from a PRD
```
# Give a local file path
/pipeline PRD.md

# Or give a Google Doc URL (requires Google Drive MCP)
/pipeline https://docs.google.com/document/d/YOUR_DOC_ID/edit
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
| `/docs` | If docs/README.md gets out of sync |

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

## Outputs and where they're saved

| Agent | Output file | Also saved to |
|-------|------------|---------------|
| explore-codebase | `SCRATCHPAD.md` | `docs/architecture/` |
| tech-doc / /pipeline | `TECH_DOC_{feature}.md` | `docs/plans/` |

Run `/docs` to regenerate `docs/README.md` index from all saved files.

## Customising for your project

After setup, add your project-specific context to `CLAUDE.md`:
- Architecture decisions already made
- Known quirks in the codebase
- Service dependencies
- Coding conventions beyond the defaults

The more context in `CLAUDE.md`, the better every agent performs.

## Google Doc support

Add `.mcp.json` to your repo root:
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

Then pass Google Doc URLs directly to any agent.

## Optional integrations

Add any of these MCP servers to `.mcp.json` to unlock richer workflows:

```json
{
  "mcpServers": {
    "github": {
      "type": "url",
      "url": "https://api.githubcopilot.com/mcp/"
    },
    "gdrive": {
      "type": "url",
      "url": "https://drivemcp.googleapis.com/mcp/v1"
    }
  }
}
```

The `vulnerability-check` skill will automatically use available MCP tools and degrade gracefully to report-only mode if none are configured.
