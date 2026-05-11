# /debug — systematic debugging with hypothesis tree
# Usage: /debug [optional: error message or file:line]
# Delegates to the debug skill — builds SCRATCHPAD_DEBUG.md with auditable reasoning

Run the debug skill to:
1. Collect the error and reproduce steps
2. Gather raw evidence (stack trace, git log, grep)
3. Build a hypothesis tree (SCRATCHPAD_DEBUG.md)
4. Eliminate branches with evidence until root cause is CONFIRMED
5. Propose a minimal fix with a regression test

Pass the error message or file:line as the argument to skip the intake prompt.
