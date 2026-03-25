#!/bin/bash
# BLUF: Automated "Sloppiness" & Placeholder Detection Script.

set -o pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$(dirname "$SCRIPT_DIR")")"
ENV_FILE="$PROJECT_ROOT/.cortex/env"
MANIFEST_FILE="$PROJECT_ROOT/ai/manifest.md"

if [ -f "$ENV_FILE" ]; then
    source "$ENV_FILE"
else
    echo "ERROR: Run 'make doctor' first."
    exit 2
fi

# Manifest/env drift gate: ensure audits are run with fresh injected entrypoints.
if [ ! -f "$MANIFEST_FILE" ]; then
    echo "ERROR: Missing $MANIFEST_FILE"
    exit 2
fi
if [ "$MANIFEST_FILE" -nt "$ENV_FILE" ]; then
    echo "ERROR: .cortex/env is stale relative to ai/manifest.md."
    echo "       Run 'make doctor' before running verification gates."
    exit 2
fi

TARGET_DIR=${1:-"$PROJECT_ROOT"}
EXIT_CODE=0

echo "Auditing: $TARGET_DIR"
trap 'echo "ERR: verify_completion.sh at line $LINENO"; exit 2' ERR

PLACEHOLDERS=("// \.\.\." "# \.\.\." "TODO" "FIXME" "pass" "NotImplementedError" "rest of code")
for pattern in "${PLACEHOLDERS[@]}"; do
    MATCHES=$(grep -rE "$pattern" "$TARGET_DIR" --exclude-dir={.git,node_modules,venv,cdk.out,.pytest_cache} --exclude="*.md" 2>/dev/null)
    if [ ! -z "$MATCHES" ]; then
        echo "FAIL: Found '$pattern'"
        EXIT_CODE=1
    fi
done

if [ -f "$PY_ENTRY_POINT" ]; then
    DIR=$(dirname "$PY_ENTRY_POINT")
    for file in $(ls "$DIR"/*.py 2>/dev/null); do
        name=$(basename "$file" .py)
        if [[ "$name" == "__init__" || "$file" == "$PY_ENTRY_POINT" ]]; then continue; fi
        grep -q "$name" "$PY_ENTRY_POINT" || { echo "FAIL: $name not in $(basename $PY_ENTRY_POINT)"; EXIT_CODE=1; }
    done
fi

if [ -f "$GO_ENTRY_POINT" ]; then
    DIR=$(dirname "$GO_ENTRY_POINT")
    for file in $(ls "$DIR"/*.go 2>/dev/null); do
        if [[ "$file" == "$GO_ENTRY_POINT" ]]; then continue; fi
        FUNCTIONS=$(grep -E "^func run[A-Z]\w+" "$file" | sed -E 's/func (run\w+).*/\1/')
        for func in $FUNCTIONS; do
            grep -q "$func" "$GO_ENTRY_POINT" || { echo "FAIL: $func not in $(basename $GO_ENTRY_POINT)"; EXIT_CODE=1; }
        done
    done
fi

if [ $EXIT_CODE -eq 0 ]; then
    echo "OK: Audit Passed."
else
    echo "FAIL: Audit Failed."
fi

exit $EXIT_CODE
