# Root Makefile for markdown-agents
# Delegates to scripts/Makefile

.PHONY: deploy deploy-ai doctor doctor-check verify build clean destroy status help

# Default target: show help
help:
	@echo "Markdown-Agents Root Makefile"
	@echo ""
	@echo "Usage:"
	@echo "  make deploy       - Deploy agent pointers (CLAUDE.md, GEMINI.md, etc.)"
	@echo "  make doctor       - Initialize/verify environment and toolchains"
	@echo "  make verify       - Run all quality gates (tests, SOLID scan, etc.)"
	@echo "  make status       - Show deployed configuration and roles/commands"
	@echo "  make clean        - Remove generated agent configuration"
	@echo "  make destroy      - Remove ALL generated files (including .cortex/ and memory)"
	@echo "  make build        - Run project-specific build (if configured)"
	@echo ""
	@echo "For more details, see scripts/Makefile"

deploy:
	@$(MAKE) -f scripts/Makefile deploy

deploy-ai:
	@$(MAKE) -f scripts/Makefile deploy-ai

doctor:
	@$(MAKE) -f scripts/Makefile doctor

doctor-check:
	@$(MAKE) -f scripts/Makefile doctor-check

verify:
	@$(MAKE) -f scripts/Makefile verify

status:
	@$(MAKE) -f scripts/Makefile status

clean:
	@$(MAKE) -f scripts/Makefile clean

destroy:
	@$(MAKE) -f scripts/Makefile destroy

build:
	@$(MAKE) -f scripts/Makefile build
