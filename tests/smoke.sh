#!/usr/bin/env bash
set -euo pipefail
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"
PY="${PYTHON:-python3}"

# Live public endpoint. History: type=sse + …/sse returned 410; the working shape
# is type=http + https://mcp.deepwiki.com/mcp. Pin both so CI catches a regression.
EXPECTED_MCP_URL="https://mcp.deepwiki.com/mcp"

echo "=== smoke: manifests are valid JSON ==="
for f in .claude-plugin/plugin.json .claude-plugin/marketplace.json marketplace-entry.json; do
    "$PY" -c "import json,sys; json.load(open('$f'))"
    echo "  ok: $f"
done

echo "=== smoke: plugin.json registers the deepwiki MCP server ==="
"$PY" - <<PYEOF
import json
m = json.load(open(".claude-plugin/plugin.json"))
assert m["name"] == "deepwiki", "name must be deepwiki"
srv = (m.get("mcpServers") or {}).get("deepwiki")
assert srv, "mcpServers.deepwiki missing"
assert srv.get("type") == "http", "deepwiki server must be type http (not sse)"
assert srv.get("url") == "$EXPECTED_MCP_URL", (
    f"deepwiki url must be exactly $EXPECTED_MCP_URL, got {srv.get('url')!r}"
)
assert len(m.get("keywords", [])) == 20, "keywords must be exactly 20"
print("  ok: deepwiki http MCP server registered at $EXPECTED_MCP_URL")
PYEOF

echo "=== smoke: marketplace-entry uses fleet url source shape ==="
"$PY" - <<'PYEOF'
import json
e = json.load(open("marketplace-entry.json"))
assert e.get("name") == "deepwiki", "marketplace-entry name must be deepwiki"
src = e.get("source") or {}
assert src.get("source") == "url", "marketplace-entry.source.source must be 'url'"
url = src.get("url") or ""
assert url == "https://github.com/88plug/deepwiki.git", (
    f"marketplace-entry source url wrong: {url!r}"
)
assert (e.get("homepage") or "").startswith("https://github.com/88plug/deepwiki")
print("  ok: marketplace-entry url source shape")
PYEOF

echo "=== smoke: all good ==="
