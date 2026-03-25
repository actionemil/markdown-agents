# Command: Ship SOP

Focus: Final gate certification, semantic commit formatting, and branch lifecycle management.

## Hard Gates
- **Zero Failures**: You are forbidden from shipping if `make verify` or `scripts/gates/verify_completion.sh` returned a non-zero exit code.
- **Evidence Verification**: You must explicitly confirm the existence of `tests/reports/last_orch_run.log` and verify it is fresh (< 30 mins).

## Steps
1. **Final Audit**: Run `make verify` one last time.
2. **Roadmap Sync**: Ensure all items in `docs/improvements/current_task_roadmap.md` are checked off.
3. **Memory Update**: Run `./scripts/update_memory.sh`.
4. **Commit Formatting**: Generate a git commit message following this template:
   ```text
   ship: <brief description>
   
   - Phase: <Active Phase from Roadmap>
   - Run ID: <bootstrap_run_id from .ai_memory>
   - Quality: SOLID Verified, TDD passed.
   ```
5. **Merge Policy**: If in a sandbox branch, perform the merge to the primary branch.

## Quality Bar
- The commit message MUST include the unique `bootstrap_run_id` to ensure traceability in the RLM Activity Log.
