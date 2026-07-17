# Changelog

## Unreleased

- Smoke pins the live MCP URL (`type=http` + `https://mcp.deepwiki.com/mcp`) and the marketplace-entry `url` source shape so the historical `/sse` 410 regression cannot land unnoticed.
- README features / MCP tools tables aligned with the docs site.

## 2026.6.23

- Initial release: wires up Cognition AI's hosted DeepWiki MCP server as a Claude Code plugin, giving read-only access to auto-generated documentation and Q&A over public GitHub repositories.
