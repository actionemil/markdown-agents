# Sovereign Engineering

Policy-based agent orchestration using Markdown SOPs and Hard Gates.

## Porting to New Projects
1. Copy the `ai/` folder (The Policy Layer).
2. Copy the `scripts/` folder (The Physics Layer).
3. Update `ai/manifest.md` with your project's landmarks (Source, Entry Points).
4. Run `make doctor` to inject local tool paths.
5. Adapt `scripts/gates/` to your language (e.g., swap `go test` for `npm test`).

## Core Loop
1. Architect Mode: Generate roadmap and Zoning Law contracts.
2. Coder Mode: Implement and pass Internal Proof Gates.

## Slash Commands (Explicit Invocation Only)
- `/review [File]`: Adversarial architectural audit. Only fires on explicit `/review` — not on casual "review", "feedback", or "what do you think" mentions.
- `/roadmap [File]`: Convert ideas doc to implementation checklist.
- `/ship [Message]`: Verified git commit.

## Natural Language Intent
- "Orchestrate [Task]": 4-phase cascade.
- "Design [Title]": New ADR + Zoning Law.
- "Bootstrap [Lang]": Generate language-specific gate scripts (make bootstrap-physics).
- "Verify": Trigger proof gates.

## Hierarchy (RLM)
- Level 2: Core SOPs (Identity).
- Level 1: .ai_memory (Compressed History).
- Level 0: Roadmap + Diffs (Working Memory).

## Alignment
| Plane | Implementation |
| :--- | :--- |
| Truth | Deterministic: find, git log, grep |
| Scenario | Checklists: current_task_roadmap.md |
| Governance| Hard Gates: scripts/gates/ |
| Memory | Tier 1-3 RLM: .ai_memory, make compact |
