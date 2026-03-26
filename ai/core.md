# Agent Core: Global Context & Standards

**Purpose:** This document defines the engineering standards, operational protocols, and core philosophies for this repository. It serves as the foundational instruction set for all AI agents.

## 1. Engineering Philosophy
- **Determinism > Magic**: Prefer explicit, predictable code and structural proof over AI "vibes" or speculative implementation.
- **No Placeholders**: Never use `// ...` or "rest of code" markers. Provide complete, syntactically correct changes.
- **Security First**: Follow the principle of least privilege. Validate all inputs, avoid hardcoded secrets, and respect strict file system boundaries.

## 2. Operational Loop (Plan -> Act -> Validate)
To ensure high-quality delivery, follow this loop for every task:
1. **Context Load**: Identify the current task roadmap or design doc before starting.
2. **Implementation**: Perform surgical, idiomatic changes that adhere to the project's existing style.
3. **Verification**: Run the project's quality gates (e.g., `make verify` or equivalent) to prove correctness.
4. **Definition of Done**: A task is only complete when its behavior is verified by a passing script or test suite.

## 3. Communication Protocols
- **BLUF (Bottom Line Up Front)**: Keep responses concise and technically focused. Skip filler and pleasantries.
- **Intent-First**: Before performing a complex change, summarize your intended approach for the user.
- **Evidence-Based**: When claiming a task is complete, provide the terminal output of the verification gates as proof.

## 4. Quality Standards
- **SOLID Principles**: Adhere to SRP, OCP, LSP, ISP, and DIP. These are enforced by the project's verification gates.
- **TDD (Test-Driven Development)**: Write or update tests alongside every feature or bug fix.
- **Dry/Simple**: Favor readability and maintainability over clever or over-engineered abstractions.

---

## Agent System

### Roles (`ai/roles/`)
Specialized roles are defined in `ai/roles/`. When a task has a clear specialist angle, read the matching role file and adopt its SOP for the duration of the task.

### Commands (`ai/commands/`)
Slash commands (e.g., `/review`, `/ship`) are defined in `ai/commands/`. When a command is invoked, read its corresponding documentation and follow the steps exactly.

### Hooks (`ai/hooks/`)
Lifecycle hooks are defined in `ai/hooks/`. These automated instructions fire during specific events (like `pre-ship` or `on-error`) to ensure consistent quality and recovery.
