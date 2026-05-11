# /audit — security audit of current changes or specified path
# Usage: /audit
#        /audit src/auth/
#        /audit [file or directory]
# Lighter than the full vulnerability-check skill — runs in main session, no Jira/PR/Slack

Review the specified files (or git diff if no argument) against the security rules:

1. Input validation — all external input validated at boundary?
2. Injection — SQL, shell, path, LDAP — all parameterised or escaped?
3. Auth/authz — every non-public endpoint has an auth check?
4. Cryptography — approved algorithms, no static IV/salt, `secrets` module for RNG?
5. Secrets — nothing hardcoded, no `.env` committed, nothing sensitive logged?
6. Error handling — no stack traces or internal paths in responses?
7. Dependencies — any new packages added? Flag for CVE check.

Format: one bullet per issue with file:line.
Severity: CRITICAL (must fix) / HIGH (should fix) / ADVISORY (consider fixing).
End with: CLEAN / ISSUES FOUND and a count per severity.

For a full repo scan with Jira + PR + Slack: use /vulnerability-check instead.
