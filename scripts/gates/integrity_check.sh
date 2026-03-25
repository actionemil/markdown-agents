#!/bin/bash
# BLUF: Verifies Metagraph Data Integrity (Sovereign Spec).

# Environment-aware path resolution
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
DB_PATH="$PROJECT_ROOT/.cortex/knowledge_graph.db"
EXIT_CODE=0

if [ ! -f "$DB_PATH" ]; then
    echo "🛑 Error: Knowledge Graph not found at $DB_PATH. Run 'make agent-setup' first."
    exit 1
fi

echo "📊 Auditing Metagraph Integrity: $DB_PATH"

# 1. Orphaned Edges Check
# Finds edges where source or target nodes are missing from the nodes table
ORPHANS=$(sqlite3 "$DB_PATH" "SELECT id FROM structural_edges WHERE target_id NOT IN (SELECT node_id FROM structural_nodes) OR source_id NOT IN (SELECT node_id FROM structural_nodes) LIMIT 100;")

if [ ! -z "$ORPHANS" ]; then
    echo "❌ INTEGRITY ERROR: Found orphaned edges (pointing to non-existent nodes)."
    echo "$ORPHANS"
    EXIT_CODE=1
fi

# 2. Metadata Integrity
MANIFEST_LINK=$(sqlite3 "$DB_PATH" "SELECT value FROM metadata WHERE key='manifest_hash';")
if [ -z "$MANIFEST_LINK" ]; then
    echo "❌ INTEGRITY ERROR: Manifest hash missing from metadata."
    EXIT_CODE=1
fi

if [ $EXIT_CODE -eq 0 ]; then
    echo "✅ Data Integrity Passed."
else
    echo "🛑 Data Integrity Issues Found."
fi

exit $EXIT_CODE
