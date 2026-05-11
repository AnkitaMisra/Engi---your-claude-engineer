---
name: scaffold
description: Generate a new module, service, or feature scaffold by reading SCRATCHPAD.md to infer existing project patterns — naming, structure, imports, error handling, tests. Produces ready-to-use files that look like they belong in the codebase.
context: fork
allowed-tools: [Read, Grep, Glob, Write, Bash]
---

# Scaffold agent
# Reads SCRATCHPAD.md and existing code to infer patterns before generating anything
# Output files follow the same conventions as the rest of the repo — no foreign patterns

## Step 1 — Understand what to scaffold

Ask the user (or extract from context):
- What type of thing to create: API endpoint / service / repository / model / worker / CLI command / other
- Name of the new thing (e.g. "UserService", "notifications endpoint", "export worker")
- Any specific behaviour it should have

## Step 2 — Read existing patterns

**Read SCRATCHPAD.md first** — this is the source of truth for architecture and patterns.
If SCRATCHPAD.md does not exist, run the explore-codebase skill first.

Then gather concrete examples by reading 1–2 existing files of the same type being scaffolded:

For **API endpoints**: find existing router files and read one
- Grep: `@app.route\|@router\.\|APIRouter\|@app\.get\|@app\.post`

For **services**: find existing service files and read one
- Grep: `class.*Service\|class.*Manager`

For **repositories**: find existing repository files and read one
- Grep: `class.*Repository\|class.*Repo`

For **models**: find existing model files and read one
- Grep: `class.*Model\|BaseModel\|db\.Model\|Table(`

For **workers / tasks**: find existing task files and read one
- Grep: `@celery\|@task\|@app\.task\|dramatiq\|rq`

For **tests**: find the test file for the type being scaffolded and read it

Also check:
- Import style: absolute vs relative, what's imported from where
- Error handling: what exception classes exist, how errors bubble up
- Logging: structlog / logging / print (and what fields are logged)
- Type hints: Pydantic models, TypedDict, plain dicts
- Async: is the codebase async? What pattern for DB calls?

## Step 3 — Infer conventions

Document the patterns found before generating code:

```
## Inferred conventions for {type}

- File location: {where this type lives}
- Naming: {class/file naming pattern}
- Base class or decorator: {if any}
- Constructor signature: {params and types}
- Error handling: {exception class and raise pattern}
- Logging: {structlog call pattern}
- Imports: {top 3-5 most common imports for this type}
- Test file location: {where the test file goes}
- Test naming: {test function naming pattern}
```

## Step 4 — Generate the scaffold

Produce complete, runnable files (not stubs). Every placeholder must be a realistic example:

### Source file

Write the new source file to the correct location inferred from Step 3.

Requirements:
- Matches the naming convention exactly (no foreign patterns)
- All public methods have type hints
- Error handling follows the project pattern
- Logging follows the project pattern
- No hardcoded values — use constructor params or config
- Includes a docstring on the class (Google-style, same as rest of codebase)

### Test file

Write a corresponding test file to the correct test location.

Requirements:
- Uses the same test framework (pytest / Jest) found in the codebase
- Mocks ALL external calls (DB, HTTP, queue)
- 3–5 tests covering: happy path, missing input, error from dependency
- Test naming matches the repo convention (test_{what}_{when}_{expected})
- Imports the new class correctly

### Registration / wiring (if needed)

If the new thing needs to be registered (router included in main app, service added to DI container, worker registered with Celery), find the registration file and produce the exact lines to add, with file path.

## Step 5 — Confirm

Tell the user:
- Files written: {list with paths}
- Any manual wiring steps needed (exact lines + file)
- The test command to run: `pytest {test_file_path} -v`
- One-sentence description of what was scaffolded

Do NOT generate partial stubs. Every generated file must be complete and runnable.
