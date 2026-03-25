You are converting an ideas/design doc into an executable implementation roadmap. No fluff. No prose explanation of what phases are. Just implementation items.

Arguments: $ARGUMENTS

Parse the arguments to extract:
- Source file: the ideas doc to convert (first path mentioned)
- Output file: the roadmap file to create (path after "into" or second path mentioned)

## Steps

1. Read the source file completely.
2. Generate the roadmap and write it to the output file.

## Roadmap format rules

**File header:**
```
# [Feature Name] Roadmap (Implementation Checklist)

**Source:** [source filename]
**Outcome:** [one sentence — what is built and what it enables]

---
```

**Phases:** Group into logical delivery phases. Each phase has:
- A heading: `## Phase N — [Name] ([Plane(s) affected])`
- One sentence of scope — what this phase achieves and why it is the right boundary.
- A `### [Subsystem Name]` subheading for each coherent work area within the phase.

**Item format (every item must have all four):**
- `- [ ] **TDD** [What to test and what invariant it asserts]. **SOLID Gate**: [Which SOLID principle is enforced and how the test structure enforces it]`
- `- [ ] **[Language]** [What to implement — concrete class/function/schema name]. **SOLID Gate**: [Which SOLID principle, and how the implementation boundary enforces it]`
- `- [ ] **SOLID** [Which abstraction boundary must exist and why]. **SOLID Gate**: [How to verify it structurally — interface, test, or architecture constraint]`
- `- [ ] **Contract** [What invariant or guarantee this item enforces for downstream consumers]. **SOLID Gate**: [How the contract is tested or validated]`

**Phase gate (end of each phase):**
```
- [ ] **Gate** [What must be green before the next phase starts. Include: test coverage floor, integration test requirement, zero-regression requirement on prior phases.]
```

**Closing section:**
```
## Cross-Doc Completion Criteria

- [ ] [Any docs that must be updated in the same change set as this roadmap's implementation]
- [ ] [Any metrics or observable thresholds that define "done"]
```

## Hard Gates
- **Phase 0 Resolution**: All items in `## Phase 0 - Open Questions` MUST be resolved and moved to an implementation phase before Phase 1 begins. You are forbidden from implementing a roadmap with open questions.
- **Cross-Doc Mandatory Items**: Every roadmap MUST include the following in the "Cross-Doc Completion Criteria":
  - [ ] ADR updated or created in `docs/adr/`.
  - [ ] `.ai_memory` updated via `./scripts/update_memory.sh`.
  - [ ] `ai/manifest.md` alignment check: verify no core axioms were violated.

## Rules
- **Contract-First:** Every roadmap item must name a concrete artifact (class, function, table, interface) and the architectural contract it satisfies.
- **Agency:** Define *what* must exist and its *boundary*, but leave the internal implementation logic to the Coder role.
- **SOLID Gates:** These are not boilerplate—each one names a specific principle (SRP/OCP/LSP/ISP/DIP) and states how the structure enforces it.
- **TDD First:** Test items always precede implementation items to ensure the agent is "Unit Tested" by its own logic.
- If the source doc has open ambiguities or unresolved design decisions, surface them as a `## Phase 0 - Open Questions` section at the top of the roadmap before Phase 1 — do not silently invent answers.
- Write the output file. Do not ask for confirmation.
