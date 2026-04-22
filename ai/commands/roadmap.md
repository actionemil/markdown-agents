# Command: Roadmap SOP

Turn design docs into phased, executable checklists.

## Context
`/roadmap <source_doc>` → structured checklist. No fluff. Just execution.

## Definition of Ready
Draft until:
- Every phase has: flag key, canary criterion, kill switch.
- Phases blocked on runtime data: explicit `Blocked by:` note, no steps.

## Steps
1. **Analyze**: Read source. Read code. Code wins. Cite file:line for every claim.
2. **Phase Decomp**: Break into phases. Each needs a **Quantitative Impact** ("Saves 10ms", "Cuts 20% errors").
3. **Items**: Concrete checklist items. No orphan code. Use **Wiring** items.
4. **Validation Gates**: Define "Green" (tests pass, lint clean). Only advance when green.
5. **Strategy Gates**: Apply `docs/knowledge/strategy/cortex-principals.md`.

## Format

### Header
```markdown
# [Feature] Implementation Roadmap
**Source**: [filename]
**Outcome**: [one sentence]
---
```

### Phase 0: Resolutions
Decision log. Kill contradictions here.
- **ID**: R[N]
- **Decision**: Final choice.
- **Evidence**: file:line.
- **Gates**: Dependent phases/items.

### Phases
Each phase needs an Impact Estimate. Item formats:
- `[ ] TDD`: [Input] -> [Assertion]. Seed or in-memory DB.
- `[ ] Implementation`: [Class/function/module].
- `[ ] Wiring`: Connect [New] to [Existing] at [file:line].
- `[ ] Contract`: [Rule/Invariant]. Ref R[N].

### Completion Criteria
- `[ ] Documentation Updated`: docs/knowledge/
- `[ ] Verification Passed`
- `[ ] Manifest Alignment`

## Rules
- **Wiring**: No floating code. Every function needs a Wire item. Find call site now.
- **Verify**: Trust nothing. Check code. Cite the line.
- **TDD**: Name data. Name result. Include 1+ failure case (null, 0, missing).
- **Consistency**: Match Phase 0 decisions. Re-read before output.
- **Math**: Show work. Worked example per formula. Flag scale failures.
- **Scope**: Execution only. Link ADRs; never inline.
- **Resolutions**: Decisions, not analysis. Max 5 sentences → else ADR.
- **Conflict**: Doc vs code → code wins. Log as R[N]. Never guess.
- **Contract-First**: Name artifacts and contracts.
- **TDD First**: Tests before code. Always.
- **Output Style**: No articles. No filler. No pleasantries. Short synonyms. No hedging. Fragments fine. Tech terms exact. Caveman prose, not code.
