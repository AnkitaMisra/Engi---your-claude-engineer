---
globs: ["**/*.ts", "**/*.tsx"]
description: TypeScript coding standards — activates only when editing .ts/.tsx files
---

# TypeScript rules

- TypeScript strict mode — no any types, no implicit any
- Zod for all external data validation — no manual type casting
- Named exports only — no default exports
- async/await — no raw .then() chains
- JSDoc on all public functions: @param, @returns, @throws
- Interfaces over type aliases for object shapes
- readonly on all props that should not be mutated
- Never use non-null assertion (!) — handle null explicitly
- Import order: node stdlib → third-party → internal → types
- No barrel files (index.ts re-exports) — import directly
