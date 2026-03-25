#!/bin/bash
# Usage: ./scripts/apply_roadmap.sh <source_file> <output_roadmap>

SOURCE=$1
OUTPUT=$2
INSTRUCTIONS="ai/commands/roadmap.md"

# Detect which AI CLI to use (defaults to 'claude')
AI_CMD=${AI_CLI:-claude}

# This script can be called by YOU or by CLAUDE/GEMINI themselves.
# It pipes the 'Roadmap' rules and the source file into the CLI agent.
cat $INSTRUCTIONS | $AI_CMD -p "Generate a roadmap for $SOURCE into $OUTPUT using these exact rules."
