#!/bin/bash
# BLUF: AST-based SOLID scanner via golangci-lint (Go) and ruff (Python).
# Checks: cyclomatic complexity, cognitive complexity, structural issues (SRP/DIP).

set -o pipefail
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
EXIT_CODE=0

echo "SOLID: Scanning Go..."
if command -v golangci-lint &>/dev/null; then
    (cd "$PROJECT_ROOT/native-worker" && \
        golangci-lint run --default none \
            --enable-only cyclop,gocognit,gocritic \
            ./...) || EXIT_CODE=1
else
    echo "WARN: golangci-lint not installed — skipping Go scan"
fi

echo "SOLID: Scanning Python..."
RUFF=$(command -v ruff || echo "$PROJECT_ROOT/.venv/bin/ruff")
if [ -x "$RUFF" ]; then
    "$RUFF" check "$PROJECT_ROOT/cortex/" || EXIT_CODE=1
else
    echo "WARN: ruff not found — skipping Python scan"
fi

[ $EXIT_CODE -eq 0 ] && echo "OK: SOLID scan passed" || echo "FAIL: SOLID violations found"
exit $EXIT_CODE
