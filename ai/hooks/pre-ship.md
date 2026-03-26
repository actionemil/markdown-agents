# Hook: Pre-Ship Validation

**Trigger:** Automatically invoked before any `ship` or final commit operation.

## Purpose
Ensure the repository is in a stable, verified state before any final delivery.

## Mandate
- **Verification Priority**: All verification gates must pass with a zero exit code.
- **Dependency Check**: Confirm all files and components referenced in the current task exist and are structurally sound.
- **Stale State Protection**: Ensure the project's environment and metadata are up-to-date with the latest changes.

## Actions
1. **Toolchain Check**: Verify that the project's environment and dependencies are fresh.
2. **Execute Quality Gates**: Run all project-specific tests, static analysis, and linting.
3. **Ghost Review**: Perform a final scan for any placeholders, debug statements, or unfinished logic.

## Error Handling
If any step fails, the shipping operation MUST be aborted immediately with a clear explanation of the failure.
