# Project Steering: Technical Ethos

**Purpose:** This file defines the project's subjective "philosophy" and high-level strategy. It does NOT contain rules that can be enforced by scripts (like SOLID, naming, or length limits).

## 1. The Design Philosophy
- **Speed over Abstraction**: Only abstract code when the repetition is proven, not when it's anticipated.
- **Explicit > Implicit**: We do not use "magic" or "hidden" behaviors. Every action should be traceable to a line of code.
- **Data-First**: Treat data as a first-class citizen; keep logic as thin, pure functions operating on that data.

## 2. Strategic Preferences
- **Library Selection**: Favor small, single-purpose libraries over large "all-in-one" frameworks.
- **User Outcome > Code Purity**: If a small "hack" significantly improves the user experience without breaking the system's integrity, it is the preferred path.
- **Developer Experience**: Prioritize "Self-Documenting" code over extensive external documentation.
