#!/bin/bash
# Claude Code Engineering Intelligence — setup script
# Run from your repo root:
# bash path/to/claude-code-engineering-intelligence/setup.sh

set -e

TEMPLATE_DIR="$(dirname "$0")"
REPO_DIR="$(pwd)"

echo ""
echo "Claude Code Engineering Intelligence Setup"
echo "=========================================="
echo "Repo: $REPO_DIR"
echo ""

# Detect language
HAS_PYTHON=false
HAS_TS=false
[ -f "pyproject.toml" ] || [ -f "requirements.txt" ] || [ -f "setup.py" ] && HAS_PYTHON=true
[ -f "tsconfig.json" ] || [ -f "package.json" ] && HAS_TS=true

echo "Detected stack:"
$HAS_PYTHON && echo "  Python backend"
$HAS_TS && echo "  TypeScript"
echo ""

# Create folders
mkdir -p .claude/skills .claude/rules .claude/commands docs

# ── CLAUDE.md ──────────────────────────────────────────────────────────────
cp "$TEMPLATE_DIR/CLAUDE.md" ./CLAUDE.md
echo "Created CLAUDE.md"

# ── MEMORY.md ──────────────────────────────────────────────────────────────
cp "$TEMPLATE_DIR/MEMORY.md" ./MEMORY.md
echo "Created MEMORY.md"

# ── Skills ─────────────────────────────────────────────────────────────────
cp "$TEMPLATE_DIR/.claude/skills/explore-codebase.md" ./.claude/skills/
cp "$TEMPLATE_DIR/.claude/skills/architect.md"        ./.claude/skills/
cp "$TEMPLATE_DIR/.claude/skills/regression.md"       ./.claude/skills/
cp "$TEMPLATE_DIR/.claude/skills/tech-doc.md"         ./.claude/skills/
cp "$TEMPLATE_DIR/.claude/skills/code-review.md"      ./.claude/skills/
cp "$TEMPLATE_DIR/.claude/skills/write-tests.md"      ./.claude/skills/
cp "$TEMPLATE_DIR/.claude/skills/write-docs.md"       ./.claude/skills/
cp "$TEMPLATE_DIR/.claude/skills/debug.md"            ./.claude/skills/
cp "$TEMPLATE_DIR/.claude/skills/scaffold.md"         ./.claude/skills/
cp "$TEMPLATE_DIR/.claude/skills/vulnerability-check.md" ./.claude/skills/
echo "Created .claude/skills/ (10 agents)"

# ── Rules ───────────────────────────────────────────────────────────────────
if $HAS_PYTHON; then
  cp "$TEMPLATE_DIR/.claude/rules/python.md" ./.claude/rules/
fi
if $HAS_TS; then
  cp "$TEMPLATE_DIR/.claude/rules/typescript.md" ./.claude/rules/
fi
cp "$TEMPLATE_DIR/.claude/rules/tests.md"    ./.claude/rules/
cp "$TEMPLATE_DIR/.claude/rules/api.md"      ./.claude/rules/
cp "$TEMPLATE_DIR/.claude/rules/security.md" ./.claude/rules/
echo "Created .claude/rules/ (language-specific + security)"

# ── Commands ────────────────────────────────────────────────────────────────
cp "$TEMPLATE_DIR/.claude/commands/pipeline.md"           ./.claude/commands/
cp "$TEMPLATE_DIR/.claude/commands/review.md"             ./.claude/commands/
cp "$TEMPLATE_DIR/.claude/commands/ship.md"               ./.claude/commands/
cp "$TEMPLATE_DIR/.claude/commands/test.md"               ./.claude/commands/
cp "$TEMPLATE_DIR/.claude/commands/explain.md"            ./.claude/commands/
cp "$TEMPLATE_DIR/.claude/commands/docs.md"               ./.claude/commands/
cp "$TEMPLATE_DIR/.claude/commands/debug.md"              ./.claude/commands/
cp "$TEMPLATE_DIR/.claude/commands/scaffold.md"           ./.claude/commands/
cp "$TEMPLATE_DIR/.claude/commands/handoff.md"            ./.claude/commands/
cp "$TEMPLATE_DIR/.claude/commands/audit.md"              ./.claude/commands/
cp "$TEMPLATE_DIR/.claude/commands/changelog.md"          ./.claude/commands/
cp "$TEMPLATE_DIR/.claude/commands/vulnerability-check.md" ./.claude/commands/
echo "Created .claude/commands/ (12 slash commands)"

echo ""
echo "=========================================="
echo "Done! Next steps:"
echo ""
echo "  1. Edit CLAUDE.md — replace ALL_CAPS with your project details"
echo "     nano CLAUDE.md"
echo ""
echo "  2. Open Claude Code"
echo "     claude"
echo ""
echo "  3. First commands to try:"
echo "     explore this codebase    → maps architecture + Mermaid diagrams"
echo "     /review                  → review current changes"
echo "     /pipeline <PRD or path>  → full PRD → tech doc pipeline"
echo ""
echo "  4. Before ending each session:"
echo "     /handoff                 → writes MEMORY.md for next session"
echo ""
echo "  5. Other useful commands:"
echo "     /debug                   → systematic debugging with hypothesis tree"
echo "     /scaffold service Foo    → generate a new service from existing patterns"
echo "     /audit                   → security audit of current changes"
echo "     /changelog               → generate changelog from git history"
echo "     /vulnerability-check     → full repo security scan + Issues + PR + Slack"
echo ""
