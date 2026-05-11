---
globs: ["**/test_*.py", "**/*_test.py", "**/*.test.ts", "**/*.test.tsx", "**/*.spec.ts"]
description: Test file conventions — activates only for test files (Python and TypeScript)
---

# Test rules

## Python tests
- pytest only — no unittest
- pytest fixtures for shared setup — no setUp/tearDown
- Mock ALL external calls — no live API calls
- pytest.mark.asyncio for async tests
- @pytest.mark.parametrize for repeated patterns

## TypeScript tests
- Jest only — no Mocha or Jasmine
- describe/it blocks — no test() at top level
- jest.mock() for all external modules
- beforeEach for shared setup, afterEach for teardown
- Async tests: async/await not done callbacks

## Both
- One assertion focus per test
- Test naming: test_{what}_{when}_{expected} (Python) / should {expected} when {when} (TS)
- No live API calls — ever
- No shared mutable state between tests
- Factory functions over hardcoded test data
