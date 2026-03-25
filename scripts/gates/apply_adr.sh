#!/bin/bash
# BLUF: Generates a new, sequentially numbered ADR.
# Usage: ./scripts/gates/apply_adr.sh "Your Title"

TITLE=$1
ADR_DIR="docs/adr"

if [ -z "$TITLE" ]; then
    echo "Usage: $0 \"Title of the ADR\""
    exit 1
fi

mkdir -p "$ADR_DIR"

# Get the next sequence number
LAST_ADR=$(ls "$ADR_DIR" | grep -E "^[0-9]{4}" | sort -r | head -n 1)
if [ -z "$LAST_ADR" ]; then
    NEXT_NUM="0001"
else
    LAST_NUM=$(echo "$LAST_ADR" | cut -d'-' -f1)
    NEXT_NUM=$(printf "%04d" $((10#$LAST_NUM + 1)))
fi

SLUG=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
FILENAME="$ADR_DIR/${NEXT_NUM}-${SLUG}.md"

cat <<EOF > "$FILENAME"
# ADR-${NEXT_NUM}: $TITLE

- **Date:** $(date +%Y-%m-%d)
- **Status:** Proposed
- **Role:** Architect

## Context
[Describe the problem and context here]

## Decision
[Describe the decision and architectural rationale]

## Consequences
[List the trade-offs and system impacts]
EOF

echo "✅ ADR Created: $FILENAME"
