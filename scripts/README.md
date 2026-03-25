# Scripts

Control plane and quality gates. Logic lives in `scripts/Makefile`.

## Quick Start

```bash
chmod +x scripts/*.sh scripts/gates/*.sh
make -f scripts/Makefile deploy-ai
make -f scripts/Makefile doctor
```

## Commands

| Command | Action |
| :--- | :--- |
| `make -f scripts/Makefile deploy-ai` | Write bootstrap pointer to all CLI agent configs (CLAUDE.md, GEMINI.md, .cursorrules, .codex, .kiro) |
| `make -f scripts/Makefile doctor` | Verify toolchains and write `.cortex/env` |
| `make -f scripts/Makefile doctor-check` | Fail if `.cortex/env` is missing or stale vs `ai/manifest.md` |
| `make -f scripts/Makefile verify` | Run all quality gates |
| `make -f scripts/Makefile build` | Placeholder (intentionally not bundled; add project-specific build script) |
| `make -f scripts/Makefile status` | Show deployed config and available roles/commands |
| `make -f scripts/Makefile clean` | Remove generated agent config files |
| `make -f scripts/Makefile destroy` | Remove all generated config including `.cortex/` and `.ai_memory` |

## How It Works

`make -f scripts/Makefile deploy` writes a single pointer to `ai/core.md` into every CLI agent's config file. Each agent reads `ai/core.md` on startup, which lists all available roles (`ai/roles/`) and slash commands (`ai/commands/`).

- **Roles** are adopted on demand — ask the agent to act as architect, reviewer, etc.
- **Commands** are invoked with `/review <file>`, `/roadmap <file>`, `/ship <message>`
- **Adding a role**: create `ai/roles/<name>.md` — no redeploy needed

## Gates (`scripts/gates/`)

| Script | Purpose |
| :--- | :--- |
| `test_all.sh` | Run unit and integration tests |
| `verify_completion.sh` | Scan for placeholders and wiring gaps |
| `solid_scanner.sh` | SOLID scan template (replace with stack-specific static analysis) |
| `integrity_check.sh` | SQL audit for knowledge graph consistency |
| `doctor.sh` | Environment health check and dependency injection |

## Rules

- No script output = no task completion.
- Gates must return exit code 0 to pass.
- Starter gates are templates; regenerate/adapt them for your repository stack.
- `destroy` is irreversible — re-run `doctor` then `deploy` to recover.
