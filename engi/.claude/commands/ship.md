# /ship — pre-commit checklist
# Usage: /ship
# Run before every commit to catch common issues

Check the staged changes for:
1. Any print() statements (should use structlog)
2. Any hardcoded URLs, API keys, or secrets
3. Any TODO or FIXME comments that should be resolved
4. Any functions missing type hints
5. Any new dependencies not in requirements.txt / pyproject.toml
6. Test coverage — are there tests for new public functions?

Report issues as a checklist. Flag blockers vs warnings.
