# Contributing to engi

Thanks for improving engi. Every skill and command is a single markdown file — easy to read and modify.

## How to contribute

1. Fork this repo
2. Create a branch: `git checkout -b feat/my-improvement`
3. Make your changes (see structure below)
4. Open a PR with a clear description of what you changed and why

## Repo structure

```
engi/
├── .claude/
│   ├── skills/      # AI agents — one file per skill
│   ├── commands/    # Slash commands — one file per command
│   └── rules/       # Path-specific rules — auto-activate by file type
├── docs/
│   └── GETTING_STARTED.md
├── CLAUDE.md        # Project config template
├── MEMORY.md        # Session memory template
└── setup.sh         # Copies everything into a user's repo
```

## Adding a new skill

Create `engi/.claude/skills/your-skill.md` with this frontmatter:

```markdown
---
name: your-skill
description: One sentence — what this skill does and when to use it
context: fork
allowed-tools: [Read, Grep, Glob, Write, Bash]
---
```

Then add it to the `setup.sh` copy list and document it in `README.md`.

## Adding a new slash command

Create `engi/.claude/commands/your-command.md`. The filename becomes the command (`/your-command`).

Then add it to the `setup.sh` copy list and document it in `README.md`.

## Guidelines

- Keep each file focused — one skill does one thing well
- No hardcoded project names, internal tooling, or company-specific references
- Test your change by running `setup.sh` against a fresh repo before opening a PR
- Update `README.md` if you add or change a skill or command
