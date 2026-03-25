# Scripts

Control plane and quality gates. Logic lives in `scripts/Makefile`; run from the repo root with plain `make`.

## Quick Start

```bash
chmod +x scripts/*.sh scripts/gates/*.sh
make doctor   # verify toolchains, inject .cortex/env
make deploy-ai   # bootstrap all CLI agents
```

## Commands

| Command | Action |
| :--- | :--- |
| `make deploy-ai` | Write bootstrap pointer to all CLI agent configs (CLAUDE.md, GEMINI.md, .cursorrules, .codex, .kiro) |
| `make doctor` | Verify toolchains and write `.cortex/env` |
| `make verify` | Run all quality gates |
| `make build` | Build the native Go worker |
| `make status` | Show deployed config and available roles/commands |
| `make clean` | Remove generated agent config files |
| `make destroy` | Remove all generated config including `.cortex/` and `.ai_memory` |

## How It Works

`make deploy` writes a single pointer to `ai/core.md` into every CLI agent's config file. Each agent reads `ai/core.md` on startup, which lists all available roles (`ai/roles/`) and slash commands (`ai/commands/`).

- **Roles** are adopted on demand — ask the agent to act as architect, reviewer, etc.
- **Commands** are invoked with `/review <file>`, `/roadmap <file>`, `/ship <message>`
- **Adding a role**: create `ai/roles/<name>.md` — no redeploy needed

## Gates (`scripts/gates/`)

| Script | Purpose |
| :--- | :--- |
| `test_all.sh` | Run unit and integration tests |
| `verify_completion.sh` | Scan for placeholders and wiring gaps |
| `zoning_validator.py` | Enforce ADR contracts against the metagraph |
| `solid_scanner.sh` | AST-based SOLID scan via golangci-lint (Go) and ruff C90 (Python) |
| `integrity_check.sh` | SQL audit for knowledge graph consistency |
| `doctor.sh` | Environment health check and dependency injection |

## Rules

- No script output = no task completion.
- Gates must return exit code 0 to pass.
- `destroy` is irreversible — re-run `doctor` then `deploy` to recover.
