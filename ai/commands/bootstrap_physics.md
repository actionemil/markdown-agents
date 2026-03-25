# Command: Bootstrap Physics SOP

Focus: Generating project-specific Hard Gates for a new environment.

## Context
A Sovereign project requires a `scripts/gates/` directory containing objective proof scripts. When porting the `ai/` folder to a new repo, you MUST generate the "Physics" (scripts) adapted to the project's primary language and toolchain.

## Selection Criteria
Identify the project's primary language and test runner from the root configuration files (e.g., package.json, pyproject.toml, go.mod, etc.).

## Mandatory Gates to Generate
Generate the following in `scripts/gates/`:

1. **test_all.sh**: A master wrapper that runs the project's full test suite. It must provide a clear Pass/Fail signal.
2. **verify_completion.sh**: A script that scans for placeholders (e.g., TODO, FIXME, "// ...", "pass") and verifies wiring in the project's primary entry points (e.g., main.py, index.ts).
3. **solid_scanner.py**: A heuristic-based structural auditor. It must flag SRP violations (e.g., oversized classes) and DIP violations (e.g., direct implementation imports).
4. **integrity_check.sh**: A script that verifies the health of the project's local state or database (if defined in the manifest).

## Implementation Rules
- **No Icons**: Use only technical text markers (OK, FAIL, ERR).
- **Environment Aware**: All scripts MUST source `.cortex/env` at the start to use injected binary paths.
- **Exit Code Contract**: 
  - 0: Pass.
  - 1: Gate Failure (Sloppy code or failing tests).
  - 2: Script Error (Missing dependencies or infrastructure failure).
- **Root Resolution**: Resolve the project root dynamically using `dirname`.
