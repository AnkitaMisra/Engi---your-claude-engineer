# /handoff — write end-of-session context to MEMORY.md
# Usage: /handoff
# Run before closing Claude Code to preserve context for the next session

Review the current session and write a complete MEMORY.md update so the next session
(or the next person) can resume without re-exploring.

Steps:
1. Run `git diff --stat HEAD` and `git log --oneline -10` to see what changed
2. Review the conversation for decisions made and open questions raised
3. Write or overwrite MEMORY.md using the template structure already in the file
4. Keep every section — write "none" if a section is empty
5. Next steps must be specific: file name, function name, exact action

Confirm: "MEMORY.md updated. Next session starts with full context."
