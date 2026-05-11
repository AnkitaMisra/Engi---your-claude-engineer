---
name: write-docs
description: Generate Google-style docstrings and README documentation for Python modules, classes, and functions. Use when adding documentation to existing code or new code that needs docs.
context: fork
allowed-tools: [Read, Glob]
---

# Documentation skill
# Runs in isolated sub-agent

Read the specified Python file and generate documentation.

For each public function, class, and module:

1. Google-style docstring with:
   - One-line summary
   - Args section (name, type, description for each)
   - Returns section (type and description)
   - Raises section (exception type and when it's raised)
   - Example in doctest format if the function is non-obvious

2. Module-level docstring explaining:
   - What this module does
   - How it fits into the broader system
   - Usage example

Output: the complete file with docstrings added inline, ready to replace the original.
