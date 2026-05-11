# /review — quick code review
# Usage: /review [optional: specific file or focus area]
# Runs in main session — use the review Skill for isolated verbose reviews

Review the current changes (git diff or specified files) for:
1. Logic errors and bugs
2. Missing error handling
3. Security concerns
4. Type safety issues
5. Missing tests for new functionality

Keep it concise — one bullet per issue, file:line reference.
End with GO / NEEDS CHANGES.
