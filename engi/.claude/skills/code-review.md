---
name: code-review
description: Review Python code for bugs, security issues, type safety, and style violations. Use for any code review task — automatically runs in isolation so verbose output stays out of main session.
context: fork
allowed-tools: [Read, Grep, Glob]
---

# Code review skill
# Runs in isolated sub-agent — only final report returns to main session
# Read-only: cannot accidentally modify files

Review the specified Python files and produce a structured report.

## CRITICAL — must fix before commit
- Logic errors that cause incorrect behaviour on valid input
- Unhandled exceptions on valid input paths
- SQL injection, command injection, path traversal risks
- Secrets or credentials in code
- Type errors that would fail at runtime
- Missing authentication/authorisation checks

## MAJOR — should fix
- Missing error handling on external calls
- Blocking I/O in async context (requests instead of httpx)
- N+1 query patterns
- Missing type hints on public functions
- Functions over 40 lines that should be extracted

## MINOR — consider fixing
- Missing docstrings on public functions
- Inconsistent naming conventions
- Import order violations
- Unnecessary complexity

Format: one bullet per issue with file:line reference and one-sentence explanation.
End with: GO / NEEDS CHANGES / REJECT and a one-line summary.
