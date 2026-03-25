#!/bin/bash
# BLUF: Sovereign Knowledge Graph Ingestor (RLM Tier 1).

set -o pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
ENV_FILE="$PROJECT_ROOT/.cortex/env"

if [ -f "$ENV_FILE" ]; then
    source "$ENV_FILE"
else
    echo "ERROR: Environment not initialized. Run 'make doctor' first."
    exit 2
fi

DB_PATH="$PROJECT_ROOT/$DB_PATH"
MANIFEST="$PROJECT_ROOT/ai/manifest.md"
MEMORY_FILE="$PROJECT_ROOT/.ai_memory"

mkdir -p "$(dirname "$DB_PATH")"

echo "Syncing Sovereign Knowledge Graph..."

sqlite3 "$DB_PATH" <<EOF
CREATE TABLE IF NOT EXISTS metadata (key TEXT PRIMARY KEY, value TEXT, updated_at DATETIME DEFAULT CURRENT_TIMESTAMP);
CREATE TABLE IF NOT EXISTS structural_nodes (node_id TEXT PRIMARY KEY, kind TEXT, body_hash TEXT, updated_at DATETIME DEFAULT CURRENT_TIMESTAMP);
CREATE TABLE IF NOT EXISTS structural_edges (id INTEGER PRIMARY KEY AUTOINCREMENT, source_id TEXT, target_id TEXT, predicate TEXT, updated_at DATETIME DEFAULT CURRENT_TIMESTAMP, UNIQUE(source_id, target_id, predicate));
EOF

if [ -f "$MANIFEST" ]; then
    MANIFEST_HASH=$(shasum -a 256 "$MANIFEST" | cut -d' ' -f1)
    sqlite3 "$DB_PATH" "INSERT OR REPLACE INTO metadata (key, value) VALUES ('manifest_hash', '$MANIFEST_HASH');"
fi

BOOTSTRAP_RUN_ID=$(date +%s)-$(head -c 8 /dev/urandom | xxd -p 2>/dev/null || echo $RANDOM)
sqlite3 "$DB_PATH" "INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_bootstrap_id', '$BOOTSTRAP_RUN_ID');"

if [ -f "$GO_ENTRY_POINT" ]; then
    grep -E "run[A-Z]\w+" "$GO_ENTRY_POINT" | sed 's/.*run/run/' | while read -r cmd; do
        sqlite3 "$DB_PATH" "INSERT OR IGNORE INTO structural_nodes (node_id, kind) VALUES ('$cmd', 'worker_command');"
    done
fi

RECENT_ERRORS=$(grep -h "ERROR" tests/reports/*.log 2>/dev/null | tail -n 5 || echo "None")

TEMP_MEM=$(mktemp)
{
    echo "### SOVEREIGN MEMORY (RLM Tier 1)"
    echo "bootstrap_run_id: $BOOTSTRAP_RUN_ID"
    echo "manifest_sha256: $(sqlite3 "$DB_PATH" "SELECT value FROM metadata WHERE key='manifest_hash';")"
    echo -e "\n#### Activity Log"
    git log -n 3 --pretty=format:"- %s (%h)" || echo "No git history"
    echo -e "\n#### Lessons Learned"
    echo "$RECENT_ERRORS"
    echo -e "\n#### Structural Truth"
    sqlite3 "$DB_PATH" "SELECT kind, COUNT(*) FROM structural_nodes GROUP BY kind;"
    echo -e "\n#### System Connectivity"
    echo "wired_handlers: [$(sqlite3 "$DB_PATH" "SELECT group_concat(node_id) FROM structural_nodes WHERE kind='worker_command';")]"
} > "$TEMP_MEM"

mv "$TEMP_MEM" "$MEMORY_FILE"
echo "OK: Memory Updated ($BOOTSTRAP_RUN_ID)."
