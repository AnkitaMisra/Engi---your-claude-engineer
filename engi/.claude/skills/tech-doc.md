---
name: tech-doc
description: Full engineering intelligence pipeline. Accepts PRD content in ANY format — paste directly, give a file path, or give a Google Doc URL/ID. Runs architect + regression analysis and writes TECH_DOC_{feature}.md to repo root AND docs/plans/ folder.
context: fork
allowed-tools: [Read, Grep, Glob, Write, Bash]
---

# Tech doc agent — full pipeline with explicit reliability checks
# PRD → Architect → [validate] → Regression → [validate] → TECH_DOC_{feature}.md

## Step 1 — Get the PRD content

A. Content pasted directly — use as-is. Most common.
B. Local file path — Read("{file_path}")
C. Google Doc URL — extract FILE_ID from URL, use gdrive_read_file_content(fileId="{FILE_ID}")
D. Google Doc file ID — gdrive_read_file_content(fileId="{FILE_ID}")

Also read CLAUDE.md and SCRATCHPAD.md if they exist.

### Stop condition — PRD content check
Before proceeding, verify:
- PRD content is not empty
- PRD has enough detail to plan from (at least a problem statement + goals)
If empty or too vague → stop and tell the user exactly what is missing. Do not proceed.

---

## Step 2 — Extract feature name
Short snake_case name from the PRD (2-4 words).
Output filename: TECH_DOC_{feature_name}.md

---

## Step 3 — Architect analysis
You are a senior software architect with 15+ years experience.

Produce:
- Executive summary (2-3 sentences)
- Architecture decisions (decision + rationale + trade-offs per decision)
- Component breakdown (responsibility, interfaces, dependencies, S/M/L/XL)
- Data model changes (schema, migrations, impact on existing data)
- Integration points (external services, internal modules, breaking changes)
- Phased rollout (Phase 1 MVP / Phase 2 Production / Phase 3 Polish)
- Risks and open questions (H/M/L likelihood, H/M/L impact, mitigation)
- Out of scope (explicit exclusions)

### Stop condition — architect output validation
Before passing to regression agent, verify the architect plan contains:
- [ ] executive_summary — present and at least 2 sentences
- [ ] components — at least 1 component defined
- [ ] phases — Phase 1 MVP defined
- [ ] risks — at least considered (can be empty list if none found)
- [ ] out_of_scope — explicitly stated

If any required section is missing:
→ Re-attempt that section with specific instruction: "Your previous output was missing {section}. Please add it now."
→ Maximum 2 retry attempts per section
→ If still missing after 2 retries → note the gap explicitly and continue

### Provenance tag — before passing to regression
Tag the architect output before handing off:
```
[ARCHITECT OUTPUT]
source: ArchitectAgent
timestamp: {now}
status: complete
---
{architect plan}
```

### Scoped handoff to regression agent
Pass to regression agent ONLY:
- The architect plan (tagged above)
- CLAUDE.md content (project standards)
- SCRATCHPAD.md summary if exists (codebase context)

Do NOT pass: full conversation history, PRD raw text, any intermediate thinking

---

## Step 4 — Regression analysis
You are a senior QA architect. Stress-test the plan from Step 3.

Search the codebase (Grep, Glob) for past regression patterns, TODOs,
historical hotfixes, and test files revealing previously fixed bugs.

Produce:
- Edge cases (boundary values, dependency failures, concurrency, bad input)
- Past regressions found in codebase (files, patterns, historical bugs)
- Integration failure modes (service down, auth expiry, format changes)
- Data integrity risks (inconsistent state, rollback gaps, race conditions)
- Required test scenarios before shipping

### Stop condition — regression output validation
Before merging, verify regression output contains:
- [ ] edge_cases — at least attempted (can be "none found")
- [ ] risks — structured with likelihood and impact
- [ ] test_scenarios — at least 1 test scenario defined

If any section is missing:
→ Re-prompt with specific feedback: "Your regression output is missing {section}. Please add it."
→ Maximum 2 retry attempts
→ If still missing → note the gap and continue with what exists

### Provenance tag — before merging
```
[REGRESSION OUTPUT]
source: RegressionAgent
timestamp: {now}
status: complete
---
{regression findings}
```

---

## Step 5 — Conflict resolution
Review regression findings against the architect plan.

For each CRITICAL risk or edge case found:
- If the architect plan already addresses it → note "covered"
- If NOT addressed → update the plan to address it
- If cannot be addressed in this iteration → mark as "accepted risk" with explicit mitigation

Do not silently blend findings. Every conflict must be explicitly resolved.

---

## Step 6 — Build the final document

```markdown
# Technical Implementation Plan: {Feature Name}

**Date**: {today}
**Status**: Draft — awaiting team review
**Source PRD**: {URL, file path, or "direct paste"}
**Pipeline**: Architect Agent → Regression Agent → Tech Doc Agent

---

## 1. Overview
{executive summary}

## 2. Architecture decisions
{decisions with rationale and trade-offs}

## 3. Implementation plan
### Phase 1 — MVP
### Phase 2 — Production
### Phase 3 — Polish

## 4. Component specifications
{per-component: responsibility, interface, dependencies}

## 5. Data model
{schema changes, migrations, impact}

## 6. Edge cases and error handling
{every identified edge case with handling strategy}

## 7. Risk register
| Risk | Likelihood | Impact | Mitigation | Status |
|------|------------|--------|------------|--------|
{one row per risk — include "covered/accepted" in Status}

## 8. Test plan
{required test scenarios before shipping}

## 9. Open questions
{questions requiring product or business input}

## 10. Out of scope
{explicit exclusions}

---
*engi — Claude Code Engineering Intelligence*
*Architect Agent + Regression Agent · {date}*
```

---

## Step 7 — Save outputs

1. Write to repo root:
   Write("TECH_DOC_{feature_name}.md", content)

2. Create docs/plans/ and save timestamped copy:
   Bash("mkdir -p docs/plans")
   Write("docs/plans/TECH_DOC_{feature_name}.md", content)
   Write("docs/plans/TECH_DOC_{feature_name}_{YYYY-MM-DD}.md", content)

3. Update docs/README.md — append this feature entry:
   "- [TECH_DOC_{feature_name}.md](plans/TECH_DOC_{feature_name}.md) — {one-line summary} ({date})"

---

## Step 8 — Final summary to user

Tell the user:
1. ✅ File written: TECH_DOC_{feature_name}.md
2. 3 key architectural decisions made
3. Top 2 risks found by regression agent
4. How many edge cases identified and addressed
5. Any sections that had to be retried or gaps that were noted
6. "Find all technical plans in docs/plans/"

If any stop condition was hit during the pipeline:
→ Report exactly which step failed, what was missing, and what action was taken
→ Never silently continue past a failure
