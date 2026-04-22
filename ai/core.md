# Agent Core

Engineering standards and protocols for all AI agents in this repo.

## 1. Philosophy
- **Determinism > Magic**: Explicit, predictable code. Structural proof over speculation.
- **No Placeholders**: Never use `// ...` or "rest of code". Complete code only.
- **Security First**: Least privilege. Validate inputs. No hardcoded secrets. Strict FS boundaries.

## 2. Operational Loop
1. **Context Load**: Find the task roadmap or design doc first.
2. **Implementation**: Surgical, idiomatic changes. Match existing style.
3. **Verification**: Run quality gates (`make verify` or equivalent).
4. **Done**: Only when behavior is verified by passing tests.

## 3. Communication
- **BLUF**: Concise, technical. No filler.
- **Intent-First**: Summarize approach before complex changes.
- **Evidence-Based**: Completion claims require verification gate output as proof.

## 4. Quality Standards
- **SOLID**: SRP, OCP, LSP, ISP, DIP. Enforced by verification gates.
- **TDD**: Tests alongside every feature or fix.
- **DRY/Simple**: Readability over cleverness.

---

## Agent System

### Roles (`ai/roles/`)
Match task to specialist role. Read the role file. Adopt its SOP.

### Commands (`ai/commands/`)
Slash commands (e.g., `/review`, `/ship`) defined here. Read the command file. Follow steps exactly.

### Hooks (`ai/hooks/`)
Lifecycle hooks (e.g., `pre-ship`, `on-error`). Fire automatically on events. Ensure consistent quality and recovery.

---

## 5. Cortex MCP Protocol
Live code-intelligence MCP server (`code-intelligence`) is running. Consult the graph before reading files, grepping, or making structural claims. See `AGENTS.md` or `.kiro/steering/cortex-protocol.md`.
