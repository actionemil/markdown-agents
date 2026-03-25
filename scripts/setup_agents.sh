#!/bin/bash
# BLUF: Bootstraps all CLI agents to use the ai/ folder as their instruction set.

CORE="ai/core.md"

POINTER="# Agent Bootstrap

Read \`$CORE\` for engineering standards, available roles, and slash commands."

write_if_changed() {
    local file=$1
    local dir
    dir=$(dirname "$file")
    [ "$dir" != "." ] && mkdir -p "$dir"
    local existing
    existing=$(cat "$file" 2>/dev/null)
    [ "$existing" = "$POINTER" ] && return 0
    printf "%s" "$POINTER" > "$file"
    echo "OK: $file"
}

write_if_changed "CLAUDE.md"
write_if_changed "GEMINI.md"
write_if_changed ".cursorrules"
write_if_changed ".codex/rules.md"
write_if_changed ".kiro/rules/agent.md"
