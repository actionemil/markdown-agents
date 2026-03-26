# Command: Ship SOP

Focus: Final gate certification, quality assurance, and verified commit formatting.

## Hard Gates
- **Zero Failures**: You are forbidden from shipping if any verification gates (e.g., `make verify`) have not passed with a zero exit code.
- **Evidence Verification**: You must explicitly confirm that the project's quality metrics (tests, linting, etc.) have been verified in the current session.

## Steps
1. **Final Audit**: Run the project's verification gates one last time.
2. **Roadmap Sync**: Ensure all items in the current roadmap or task list are completed and verified.
3. **Documentation Update**: Synchronize the project's documentation, design documents, and memory logs.
4. **Commit Formatting**: Generate a git commit message following this template:
   ```text
   ship: <brief description>

   - Status: Verified by [Project Gates]
   - Quality: TDD and SOLID principles satisfied.
   - Documentation: Updated.
   ```
5. **Merge/Ship**: Perform the final commit or merge operation as requested.

## Quality Bar
- The commit message should be concise and accurately reflect the scope of the verified changes.
- Ensure that the repository is in a clean, buildable state before shipping.
