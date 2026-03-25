#!/bin/bash
# BLUF: The "Final Gate". Verifies everything before committing.

set -e

echo "🚀 Preparing to SHIP: Final Hard Gate Audit..."

# 1. Run full verification
make verify

# 2. Run security audit
make infra-check

# 3. Perform Git Commit
echo "✅ All gates passed. committing tracked changes..."
git add -u
git commit -m "$1"

echo "✨ SHIP SUCCESSFUL."
