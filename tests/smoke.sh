#!/usr/bin/env bash
set -euo pipefail
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"
PY="${PYTHON:-python3}"

echo "=== smoke: manifests are valid JSON ==="
for f in .claude-plugin/plugin.json .claude-plugin/marketplace.json marketplace-entry.json; do
    "$PY" -c "import json,sys; json.load(open('$f'))"
    echo "  ok: $f"
done

echo "=== smoke: plugin.json registers the deepwiki MCP server ==="
"$PY" - <<'PYEOF'
import json
m = json.load(open(".claude-plugin/plugin.json"))
assert m["name"] == "deepwiki", "name must be deepwiki"
srv = (m.get("mcpServers") or {}).get("deepwiki")
assert srv, "mcpServers.deepwiki missing"
assert srv.get("type") == "http", "deepwiki server must be type http"
assert srv.get("url", "").startswith("https://"), "deepwiki url must be https"
assert len(m.get("keywords", [])) == 20, "keywords must be exactly 20"
print("  ok: deepwiki http MCP server registered")
PYEOF

echo "=== smoke: all good ==="
