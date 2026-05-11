#!/bin/bash
# engi — Claude Code Engineering Intelligence
# Run from your repo root:
# bash path/to/engi/setup.sh

set -e

TEMPLATE_DIR="$(dirname "$0")"
REPO_DIR="$(pwd)"

echo ""
echo "engi — Claude Code Engineering Intelligence"
echo "============================================"
echo "Repo: $REPO_DIR"
echo ""

# Detect language
HAS_PYTHON=false
HAS_TS=false
[ -f "pyproject.toml" ] || [ -f "requirements.txt" ] || [ -f "setup.py" ] && HAS_PYTHON=true
[ -f "tsconfig.json" ] || [ -f "package.json" ] && HAS_TS=true

echo "Detected stack:"
$HAS_PYTHON && echo "  Python"
$HAS_TS && echo "  TypeScript"
echo ""

mkdir -p .claude/skills .claude/rules .claude/commands docs

cp "$TEMPLATE_DIR/CLAUDE.md"  ./CLAUDE.md  && echo "Created CLAUDE.md"
cp "$TEMPLATE_DIR/MEMORY.md"  ./MEMORY.md  && echo "Created MEMORY.md"

for f in architect code-review debug explore-codebase regression scaffold tech-doc write-docs write-tests vulnerability-check; do
  cp "$TEMPLATE_DIR/.claude/skills/$f.md" ./.claude/skills/
done
echo "Created .claude/skills/ (10 agents)"

if $HAS_PYTHON; then cp "$TEMPLATE_DIR/.claude/rules/python.md" ./.claude/rules/; fi
if $HAS_TS;     then cp "$TEMPLATE_DIR/.claude/rules/typescript.md" ./.claude/rules/; fi
cp "$TEMPLATE_DIR/.claude/rules/tests.md"    ./.claude/rules/
cp "$TEMPLATE_DIR/.claude/rules/api.md"      ./.claude/rules/
cp "$TEMPLATE_DIR/.claude/rules/security.md" ./.claude/rules/
echo "Created .claude/rules/"

for f in audit changelog debug docs explain handoff pipeline review scaffold ship test vulnerability-check; do
  cp "$TEMPLATE_DIR/.claude/commands/$f.md" ./.claude/commands/
done
echo "Created .claude/commands/ (12 slash commands)"

echo ""
echo "============================================"
echo "Done! Next steps:"
echo ""
echo "  1. Edit CLAUDE.md — fill in your project details"
echo "  2. Open Claude Code:  claude"
echo "  3. Try:  explore this codebase"
echo "           /pipeline PRD.md"
echo "           /review"
echo "           /handoff   (end of every session)"
echo ""
