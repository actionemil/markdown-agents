#!/bin/bash
# BLUF: Automated "Sloppiness" & Placeholder Detection Script.

# [TEMPLATE] This script is a placeholder for your project's completion and wiring checks.
# 1. Adapt the PLACEHOLDERS array to match your language's comment patterns.
# 2. Add project-specific "Logic Wiring" checks below.
# 3. Ensure this script returns exit code 0 on success, and non-zero on failure.

set -o pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$(dirname "$SCRIPT_DIR")")"

EXIT_CODE=0

# 1. Placeholder Detection
# -----------------------------------------------------------------------------
echo ">>> RUNNING PLACEHOLDER AUDIT..."
PLACEHOLDERS=("// \.\.\." "# \.\.\." "TODO" "FIXME" "pass" "NotImplementedError" "rest of code")
for pattern in "${PLACEHOLDERS[@]}"; do
    # Grep for placeholders, excluding common build/dependency directories
    MATCHES=$(grep -rE "$pattern" "$PROJECT_ROOT" --exclude-dir={.git,node_modules,venv,cdk.out,.pytest_cache} --exclude="*.md" 2>/dev/null)
    if [ ! -z "$MATCHES" ]; then
        echo "FAIL: Found placeholder matching '$pattern'"
        echo "$MATCHES"
        EXIT_CODE=1
    fi
done

# 2. Logic Wiring Audit (Project-Specific)
# -----------------------------------------------------------------------------
# [TEMPLATE] Add your own wiring checks here. 
# Example: Verify that all files in a directory are imported by the entry point.
echo ">>> RUNNING LOGIC WIRING AUDIT (Template)..."
echo "HINT: Ask your CLI agent to 'Bootstrap the wiring audit for [Your Language]'"

# -----------------------------------------------------------------------------

if [ $EXIT_CODE -eq 0 ]; then
    echo "OK: Audit Passed."
else
    echo "FAIL: Audit Failed."
fi

exit $EXIT_CODE
