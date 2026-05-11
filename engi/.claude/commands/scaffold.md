# /scaffold — generate a new module, service, or feature
# Usage: /scaffold [type] [name]
# Example: /scaffold service PaymentService
# Example: /scaffold endpoint /api/v1/reconcile
# Delegates to the scaffold skill — reads SCRATCHPAD.md to infer patterns first

Run the scaffold skill to generate a new component that matches the existing codebase conventions.
Reads SCRATCHPAD.md and 1-2 existing files of the same type before generating anything.
Produces: source file + test file + wiring instructions.

Requires SCRATCHPAD.md to exist. If it doesn't, run "explore this codebase" first.
