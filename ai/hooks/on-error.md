# Hook: On-Error Recovery

**Trigger:** When a command, test, or gate fails.

## Purpose
Perform diagnostic thinking instead of "blind retrying."

## Actions
1. **Root Cause Analysis:** Analyze the last 20 lines of terminal output to identify if the failure is environmental, logic-based, or a missing dependency.
2. **Rollback Assessment:** If the failure is critical, assess if a `git checkout` of the affected file is safer than a "fix-forward" approach.
3. **Strategy Pivot:** Propose a corrected approach to the user before attempting the fix.

## Mandate
If a test fails twice for the same reason, you MUST stop and ask for clarification or provide a deep-dive analysis.
