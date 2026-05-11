# /pipeline — full engineering intelligence pipeline
# Usage: paste your PRD then type /pipeline
# That's it. One command runs everything.
#
# What happens:
# 1. Architect agent reads PRD as senior architect → implementation plan
# 2. Regression agent stress-tests the plan → edge cases + risk report
# 3. Tech doc agent merges both → writes TECH_DOC_{feature}.md to repo
#
# Also works with:
# /pipeline PRD.md
# /pipeline https://docs.google.com/document/d/YOUR_DOC_ID/edit

Run the full tech-doc pipeline on the provided PRD content or file.
Produce TECH_DOC_{feature_name}.md with the complete implementation plan.
