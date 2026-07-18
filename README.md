<div align="center">

# DeepWiki

Claude Code plugin for DeepWiki MCP — chat with any public GitHub repo's auto-generated documentation, wiki pages, and Q&A without cloning.

[![plugin-validate](https://github.com/88plug/deepwiki/actions/workflows/plugin-validate.yml/badge.svg)](https://github.com/88plug/deepwiki/actions/workflows/plugin-validate.yml)
[![License: FSL-1.1-ALv2](https://img.shields.io/badge/license-FSL--1.1--ALv2-blue?style=flat)](LICENSE)
[![Docs](https://img.shields.io/badge/docs-online-2ea44f?style=flat)](https://88plug.github.io/deepwiki/)
[![Claude Code plugin](https://img.shields.io/badge/Claude%20Code-plugin-8A2BE2?style=flat)](https://github.com/88plug/claude-code-plugins)
[![DeepWiki](https://deepwiki.com/badge.svg)](https://deepwiki.com/88plug/deepwiki)

</div>

## Install

```text
/plugin marketplace add 88plug/claude-code-plugins
/plugin install deepwiki@88plug
```

No API key, no local MCP server, no config file. The Claude Code plugin registers Cognition AI's remote DeepWiki MCP endpoint; Claude Code connects over HTTP.

## Quickstart

After install, ask your AI agent about any public GitHub repository:

```text
Using deepwiki, how does the React reconciler schedule work?
```

The agent calls the DeepWiki MCP tools, reads the indexed documentation for `facebook/react`, and answers in the same turn — no clone, no local wiki build.

Other prompts that work well:

```text
Using deepwiki, summarize the architecture of vercel/next.js
Using deepwiki, what does read_wiki_structure return for torvalds/linux?
```

Mention `deepwiki` (or the owner/repo) so the agent routes to the MCP server instead of guessing from training data.

## What it does

DeepWiki is a thin Claude Code plugin that wires up Cognition AI's hosted [DeepWiki MCP server](https://docs.devin.ai/work-with-devin/deepwiki-mcp) (Model Context Protocol). It gives Claude and other AI agents read-only access to auto-generated GitHub documentation and natural-language Q&A over public repositories.

Use it when you want to:

- Research an unfamiliar codebase before adopting or contributing
- Answer dependency questions without leaving your Claude Code session
- Pull architecture and API context into a task without cloning gigabytes of source
- Give LLM agents a wiki-style documentation surface instead of raw tree walks

Any public repo at `github.com/<owner>/<repo>` is reachable. Cognition's DeepWiki indexes it and serves the docs; this plugin is the one-command install path so your agent can query it programmatically.

## Features

| Feature | Detail |
| --- | --- |
| Marketplace install | One command via the [88plug Claude Code plugins marketplace](https://github.com/88plug/claude-code-plugins) |
| No API key | No local process, no manual MCP config |
| Remote MCP server | HTTP to `https://mcp.deepwiki.com/mcp` |
| Read-only research | Agent reads docs and asks questions — nothing more |
| Any public GitHub repo | Works against `github.com/<owner>/<repo>` |
| Agent-friendly | Surfaces as named MCP tools your LLM can call |

## MCP tools

The plugin exposes one MCP connection named `deepwiki` (model-context-protocol tools):

| Tool | What it does |
| --- | --- |
| `read_wiki_structure` | List auto-generated documentation / wiki pages for a repository |
| `read_wiki_contents` | Fetch the full documentation for a repository |
| `ask_question` | Ask a natural-language question about a repository; get an AI-generated answer |

You normally do not call these by hand. Mention `deepwiki` or a GitHub repository in your prompt and the agent selects the right tool. That workflow fits AI agents, automation, and developer-tools CLI use inside Claude Code.

## Who it is for

- Developers who use Claude Code (Anthropic) and need fast documentation lookup on public GitHub projects
- AI agent builders who want a documentation / wiki MCP server without hosting one
- Teams doing LLM-assisted research, onboarding, or dependency review against open-source codebases
- Anyone who wants RAG-style answers over repo docs without standing up a local index

## Remote service

> [!NOTE]
> This plugin is configuration only. Indexing, the model, and the served documentation are operated by [Cognition AI](https://cognition.ai) (the team behind Devin) at `https://mcp.deepwiki.com/mcp`. 88plug does not run the underlying service. When the agent queries DeepWiki, your query text goes to that endpoint; the plugin does not proxy or log anything. Only public repositories are indexed — do not send private repository names.

<details>
<summary>What this plugin is, and what it isn't</summary>

- **Is:** a small plugin manifest that registers the remote MCP endpoint and surfaces it through the 88plug marketplace as a single install command. No original business logic.
- **Is not:** the DeepWiki service itself. If the upstream endpoint changes or goes down, this plugin is just config — open the manifest and update the URL.

</details>

## Development

Local checkout is only needed if you are changing the plugin packaging:

```bash
git clone https://github.com/88plug/deepwiki.git
cd deepwiki
claude --plugin-dir "$PWD"
```

The live MCP URL is pinned in [`.claude-plugin/plugin.json`](.claude-plugin/plugin.json) (`type: http`, `https://mcp.deepwiki.com/mcp`). See [tests/smoke.sh](tests/smoke.sh) for the smoke checks that guard that URL and the marketplace entry shape.

Online docs: [88plug.github.io/deepwiki](https://88plug.github.io/deepwiki/).

## Contributing

Issues and pull requests are welcome at [88plug/deepwiki](https://github.com/88plug/deepwiki). Keep changes small; the plugin is intentionally a thin wrapper over the remote MCP server.

## License

Released under the [Functional Source License, Version 1.1, ALv2 Future License](LICENSE) (`FSL-1.1-ALv2`).

You may use, copy, modify, and redistribute it for any purpose except a Competing Use. Each released version converts to the Apache License 2.0 on the second anniversary of its release date. For commercial-use inquiries outside the Permitted Purpose, contact andrew@88plug.com.
