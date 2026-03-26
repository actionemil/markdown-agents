# Command: Roadmap SOP

Focus: Converting design/idea documents into executable implementation roadmaps.

## Context
When a user invokes `/roadmap <source_doc>`, you are transforming a high-level design into a structured, phase-based checklist for implementation.

## Steps
1. **Analyze Source**: Read the source document and extract core requirements, architectural constraints, and deliverables.
2. **Phase Decomposition**: Break the work into logical phases (e.g., Foundation, Core Logic, Integration, Validation).
3. **Item Generation**: Create concrete, actionable checklist items for each phase.
4. **Validation Gates**: Define what must be "Green" (tests passed, linting clean) before transitioning between phases.

## Roadmap Format Rules

### Header
```markdown
# [Feature Name] Implementation Roadmap

**Source**: [source_filename]
**Outcome**: [one-sentence summary of the final deliverable]
---
```

### Phases
Each phase should have a clear scope and a set of actionable items. Use the following format for each item:
- `[ ] **TDD**: [What to test and the invariant it asserts]`
- `[ ] **Implementation**: [Concrete class, function, or module to implement]`
- `[ ] **Contract**: [The interface or invariant this item enforces for downstream consumers]`

### Completion Criteria
Every roadmap must include a final "Completion Criteria" section:
- `[ ] Documentation Updated`: Ensure READMEs or other docs reflect the changes.
- `[ ] Verification Passed`: Successful run of all project-specific gates.
- `[ ] Manifest Alignment`: Ensure no core project mandates were violated.

## Rules
- **Contract-First**: Every item must name a concrete artifact and the architectural contract it satisfies.
- **TDD First**: Test items should precede implementation items to ensure a test-driven approach.
- **No Ambiguity**: If the source document has open questions, surface them in a "Phase 0: Open Questions" section instead of guessing.
- **Automatic Output**: Write the roadmap to the requested output file without asking for confirmation.
