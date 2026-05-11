# /changelog — generate a changelog entry for the current branch or date range
# Usage: /changelog
#        /changelog v1.2.0..v1.3.0
#        /changelog --since 2024-01-01
#        /changelog --pr 42

Generate a human-readable changelog entry from git history.

Steps:
1. If a range or PR is given, use it. Otherwise default to commits since the last tag:
   `git log $(git describe --tags --abbrev=0)..HEAD --oneline`
2. Group commits by type prefix (feat, fix, docs, refactor, perf, chore, test):
   - feat → Added
   - fix → Fixed
   - perf → Improved
   - refactor → Changed (internal)
   - docs → Documentation
   - chore / test / ci → (omit unless significant)
3. For each commit: expand the subject into a user-facing sentence (remove jargon,
   reference ticket number if present in the message)
4. Output in Keep a Changelog format:

```
## [Unreleased] — {date}

### Added
- {feature description} ({ticket or commit})

### Fixed
- {bug description} ({ticket or commit})

### Improved
- {performance or UX improvement}

### Changed
- {breaking change or internal change worth noting}
```

5. Ask: "Append this to CHANGELOG.md?" — if yes, prepend the entry below the `# Changelog` header.

Omit commits with no user-facing impact (typos, test-only, CI config).
Keep each line to one sentence. Audience: engineers reading release notes.
