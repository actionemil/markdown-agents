# 🤖 markdown-agents

**A portable, Markdown-first agent orchestration kit for professional software engineering.**

Maintain consistent AI agent behavior across any repository without manual prompt-engineering. `markdown-agents` provides a policy layer (roles & commands) and a physics layer (verification gates) to ensure your AI co-pilots follow your project's rules.

---

## 🚀 Quick Start (3 Steps)

1. **Copy** the `ai/` and `scripts/` folders into your target project.
2. **Deploy** agent pointers (supports Claude, Gemini, Cursor, and more):
   ```bash
   make deploy
   ```
3. **Initialize** the environment and verify toolchains:
   ```bash
   make doctor
   ```

---

## 🛠️ How to Use

Once deployed, your CLI agent (e.g., Gemini CLI, Claude Engineer, Cursor) will automatically load the project's **Roles** and **Slash Commands**.

### Available Slash Commands
- `/review [file]` — Adversarial architectural audit of a specific file.
- `/roadmap [file]` — Convert a design doc/idea into a structured implementation checklist.
- `/ship [message]` — Run all verification gates and perform a verified git commit.

### Agent Roles
Ask your agent to adopt a role defined in `ai/roles/`:
- **Architect**: For high-level system design and roadmapping.
- **Coder**: For implementation and TDD.
- **Auditor**: For security and compliance checks.
- **Reviewer**: For code quality and PR reviews.

### Lifecycle Hooks
Hooks in `ai/hooks/` are automated instructions that fire during specific events:
- **pre-ship** — Automated quality verification before any `ship` operation.

---

## 🏗️ Bootstrapping the Physics Layer

`markdown-agents` is **language-agnostic**. It ships with **Starter Gate Templates** in `scripts/gates/` that intentionally fail until they are adapted to your specific tech stack.

### The Bootstrapping Workflow
Once you've copied the folders and run `make deploy`, ask your CLI agent (e.g., Gemini CLI, Claude Engineer) to:

> "Bootstrap the physics layer for this repository. Adapt the scripts in `scripts/gates/` so `make verify` works for my [Go / Python / Rust / TS] project. Ensure `solid_scanner.sh` uses [Your Preferred Tool] and `test_all.sh` runs [Your Test Command]."

### Why this works?
- **Portability**: The repo doesn't care if you use Go, Python, or Rust.
- **Agent-Generated Proof**: Your agent uses its own knowledge of your stack to write the real verification logic, which then "locks in" the quality requirements for all future work.

---

## 📂 Repository Structure

| Path | Purpose | Layer |
| :--- | :--- | :--- |
| `ai/` | Policies, Roles, and Slash Commands | **Policy** |
| `scripts/` | Execution scripts and verification gates | **Physics** |
| `scripts/gates/` | Hard verification scripts (Tests, SOLID, etc.) | **Quality** |
| `Makefile` | Simplified command interface | **Control** |

---

## 📖 Commands Reference

| Command | Action |
| :--- | :--- |
| `make deploy` | Write bootstrap pointers to agent config files (CLAUDE.md, GEMINI.md, etc.) |
| `make doctor` | Initialize/verify toolchains and write `.cortex/env` |
| `make verify` | Run all quality gates (tests, completion checks, static analysis) |
| `make status` | Show deployed configuration and available roles/commands |
| `make clean` | Remove generated agent configuration |
| `make destroy` | Remove **all** generated files (irreversible) |

---

## 💡 Why markdown-agents?

- **Portable**: Works in any repo. Just copy-paste the folders.
- **Agent-Agnostic**: Works with any CLI agent that supports `CLAUDE.md`, `GEMINI.md`, or `.cursorrules`.
- **Deterministic**: Verification gates ensure that AI-generated code actually builds and passes tests before you ship.
- **Sovereign**: You own the prompts and the rules; they live in your repo, not in a hidden system prompt.
