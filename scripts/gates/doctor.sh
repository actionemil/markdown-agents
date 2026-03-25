#!/bin/bash
# BLUF: Environment Health Check & Topology Injection.

EXIT_CODE=0
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
MANIFEST="$PROJECT_ROOT/ai/manifest.md"
ENV_FILE="$PROJECT_ROOT/.cortex/env"
MODE="${1:-}"

mkdir -p "$PROJECT_ROOT/.cortex"

if [ "$MODE" = "--check" ]; then
    if [ ! -f "$MANIFEST" ]; then
        echo "ERROR: ai/manifest.md missing."
        exit 2
    fi
    if [ ! -f "$ENV_FILE" ]; then
        echo "ERROR: .cortex/env missing. Run 'make doctor'."
        exit 2
    fi
    if [ "$MANIFEST" -nt "$ENV_FILE" ]; then
        echo "ERROR: .cortex/env is stale relative to ai/manifest.md. Run 'make doctor'."
        exit 2
    fi
    echo "OK: doctor-check passed (.cortex/env is fresh)."
    exit 0
fi

echo "Doctor: Initializing Sovereign Environment..."

if [ -f "$MANIFEST" ]; then
    echo "Ingesting Topology from Manifest..."
    SOURCE_DIR=$(grep 'SOURCE_DIR=' "$MANIFEST" | cut -d'"' -f2)
    GO_ENTRY=$(grep 'GO_ENTRY_POINT=' "$MANIFEST" | cut -d'"' -f2)
    PY_ENTRY=$(grep 'PY_ENTRY_POINT=' "$MANIFEST" | cut -d'"' -f2)
    DB_PATH=$(grep 'DB_PATH=' "$MANIFEST" | cut -d'"' -f2)
else
    echo "ERROR: ai/manifest.md missing."
    exit 1
fi

{
    echo "# GENERATED FILE. DO NOT EDIT."
    echo "# Regenerate via: make doctor"
    echo "# Injected Project Dependencies"
    echo "OS_TYPE=$(uname -s | tr '[:upper:]' '[:lower:]')"
    echo "ARCH_TYPE=$(uname -m)"
    echo "PROJECT_ROOT=$PROJECT_ROOT"
    echo "SOURCE_DIR=$SOURCE_DIR"
    echo "GO_ENTRY_POINT=$GO_ENTRY"
    echo "PY_ENTRY_POINT=$PY_ENTRY"
    echo "DB_PATH=$DB_PATH"
} > "$ENV_FILE"

validate_tool() {
    local label=$1; local cmd=$2; local var=$3
    local path=$(command -v "$cmd" 2>/dev/null)
    if [ -n "$path" ]; then
        echo "OK: $label found: $path"
        echo "$var=$path" >> "$ENV_FILE"
    else
        echo "FAIL: $label ($cmd) missing."
        return 1
    fi
}

validate_tool "Python 3" "python3" "PYTHON_BIN" || EXIT_CODE=1
validate_tool "Go" "go" "GO_BIN" || EXIT_CODE=1
AI_PATH=$(command -v gemini || command -v claude || echo "unknown")
echo "AI_CLI_BIN=$AI_PATH" >> "$ENV_FILE"

if [ $EXIT_CODE -eq 0 ]; then
    echo "Status: HEALTHY. Topology: $SOURCE_DIR -> $GO_ENTRY"
else
    echo "Status: ISSUES detected."
fi

exit $EXIT_CODE
