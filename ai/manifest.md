# Project Manifest

## 1. Core Mandate
[Describe the high-level goal of the project here]

## 2. System Topology (Landmarks)
# [IMPORTANT] Update these paths for your project stack:
# -----------------------------------------------------------------------------
SOURCE_DIR="src"                        # Root directory of your source code
ENTRY_POINT="src/main.py"               # Primary application entry point
TEST_DIR="tests"                        # Directory containing your test suite
DB_PATH=".cortex/knowledge_graph.db"    # Runtime state/memory database path
# -----------------------------------------------------------------------------

## 3. Operational Mandates
- **Determinism > Magic**: Prefer physical proof (scripts) over AI "vibes".
- **Sovereign Identity**: Machine-bound HMAC trust and high-entropy run IDs.
- **Hard Gates**: "No Script Output = No Task Completion."

## 4. Quality Gates
- **SOLID**: SRP, OCP, LSP, ISP, DIP are non-negotiable structural laws.
- **TDD**: Tests must exist before or alongside implementation.
