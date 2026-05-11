---
name: write-tests
description: Generate comprehensive tests for Python or TypeScript code. Auto-detects language from file extension. Covers happy path, edge cases, and error cases. Use when you need test coverage for existing or new code.
context: fork
allowed-tools: [Read, Grep, Glob]
---

# Test generation skill
# Runs in isolated sub-agent — read-only
# Auto-detects Python vs TypeScript from file extension

Read the specified file and detect the language:
- .py files → generate pytest tests
- .ts / .tsx files → generate Jest tests

## For Python files — generate pytest

- pytest with pytest-asyncio for async functions
- pytest-mock for all external dependencies
- Test naming: test_{function}_{scenario}_{expected}
- @pytest.mark.parametrize for repeated patterns
- Fixtures for shared setup

## For TypeScript files — generate Jest

- Jest with describe/it blocks
- jest.mock() for all external modules
- beforeEach for shared setup
- async/await for async functions
- TypeScript types on all test variables

## For both — cover these cases per function:
1. Happy path — normal valid inputs
2. Edge cases — boundary values, empty, null, max
3. Error cases — invalid inputs, missing data
4. Integration — external calls (mocked)

Output: complete test file ready to use.
- Python → tests/test_{filename}.py
- TypeScript → {filename}.test.ts alongside source
