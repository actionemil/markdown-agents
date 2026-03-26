# Hook: Post-Task Sync

**Trigger:** After an implementation task is completed but before shipping.

## Purpose
Maintain consistency between the codebase and its documentation/metadata.

## Actions
1. **Documentation Check**: Ensure any new public APIs, CLI flags, or major logic changes are reflected in the project's READMEs or `/docs`.
2. **Roadmap Update**: Mark the completed task as finished in the project's roadmap or task list.
3. **Memory Synchronization**: Ensure the current session's learnings and decisions are recorded in the project's memory or session history.

## Mandate
No task is "Done" until the documentation reflects the reality of the code and the project's status is synchronized.
