SCRIPTS_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
ROOT        := $(abspath $(SCRIPTS_DIR)/..)

.PHONY: deploy deploy-ai doctor doctor-check verify build clean destroy status

deploy-ai:
	@cd $(ROOT) && ./scripts/setup_agents.sh

deploy: deploy-ai

doctor:
	@cd $(ROOT) && ./scripts/gates/doctor.sh

doctor-check:
	@cd $(ROOT) && ./scripts/gates/doctor.sh --check

verify:
	@cd $(ROOT) && ./scripts/gates/doctor.sh --check
	@cd $(ROOT) && ./scripts/gates/verify_completion.sh
	@cd $(ROOT) && ./scripts/gates/test_all.sh
	@cd $(ROOT) && ./scripts/gates/solid_scanner.sh

build:
	@cd $(ROOT) && ./scripts/gates/build_native_worker.sh

clean:
	@cd $(ROOT) && rm -f CLAUDE.md .cursorrules GEMINI.md .agent_context
	@cd $(ROOT) && rm -rf .codex .kiro
	@echo "OK: Agent config cleaned."

destroy:
	@cd $(ROOT) && rm -f CLAUDE.md .cursorrules GEMINI.md .agent_context .ai_memory
	@cd $(ROOT) && rm -rf .codex .kiro .cortex
	@echo "OK: All generated config destroyed. Run 'make doctor' to reinitialize."

status:
	@echo "=== Deployed ==="
	@cd $(ROOT) && cat CLAUDE.md 2>/dev/null || echo "Not deployed. Run 'make deploy'."
	@echo ""
	@echo "=== Available Roles ==="
	@cd $(ROOT) && ls ai/roles/*.md | xargs -I{} basename {} .md
	@echo ""
	@echo "=== Available Commands ==="
	@cd $(ROOT) && ls ai/commands/*.md | xargs -I{} basename {} .md
