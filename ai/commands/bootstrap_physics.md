# Command: Bootstrap Physics SOP

Focus: Generating project-specific verification gates for a new environment.

## Context
A project requires a `scripts/gates/` directory containing objective verification scripts. When porting the `ai/` folder to a new repo, you MUST generate the "Physics" (scripts) adapted to the project's primary language and toolchain.

## Selection Criteria
Identify the project's primary language and test runner from the root configuration files (e.g., `package.json`, `pyproject.toml`, `go.mod`, etc.).

## Mandatory Gates to Generate
Generate the following in `scripts/gates/`:

1. **test_all.sh**: A master wrapper that runs the project's full test suite. It must provide a clear Pass/Fail signal.
2. **verify_completion.sh**: A script that scans for placeholders (e.g., `TODO`, `FIXME`, `// ...`, `pass`) and verifies integration in the project's primary entry points.
3. **solid_scanner.sh**: A structural auditor that flags violations of SRP, OCP, LSP, ISP, and DIP. It may call a project-specific scanner in Go, Python, or another language.
4. **doctor.sh**: A script that verifies the health of the project's toolchain and environment.

## Implementation Rules
- **No Icons**: Use only technical text markers (OK, FAIL, ERR).
- **Environment Aware**: All scripts should source any required environment variables or configurations at the start.
- **Exit Code Contract**: 
  - 0: Pass.
  - 1: Gate Failure (Sloppy code or failing tests).
  - 2: Script Error (Missing dependencies or infrastructure failure).
- **Root Resolution**: Resolve the project root dynamically using `dirname`.
