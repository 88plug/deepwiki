# DeepWiki

Read any public GitHub repo's auto-generated documentation from inside Claude Code — no cloning, no API key.

[![plugin-validate](https://github.com/88plug/deepwiki/actions/workflows/plugin-validate.yml/badge.svg)](https://github.com/88plug/deepwiki/actions/workflows/plugin-validate.yml)
[![License: FSL-1.1-ALv2](https://img.shields.io/badge/license-FSL--1.1--ALv2-blue?style=flat)](https://github.com/88plug/deepwiki/blob/main/LICENSE)
[![Claude Code plugin](https://img.shields.io/badge/Claude%20Code-plugin-8A2BE2?style=flat)](https://github.com/88plug/claude-code-plugins)
[![Ask DeepWiki](https://deepwiki.com/badge.svg)](https://deepwiki.com/88plug/deepwiki)

## Install

From the 88plug marketplace (inside Claude Code):

```sh
/plugin marketplace add 88plug/claude-code-plugins
/plugin install deepwiki@88plug
```

### Grok Build

```text
grok plugin marketplace add 88plug/claude-code-plugins
grok plugin install deepwiki@88plug --trust
```


!!! tip
    That is the whole setup. No API key, no local server, no MCP config file.
    The plugin registers Cognition AI's remote MCP endpoint; Claude Code connects
    over HTTP.

## Quickstart

After installing, ask about any public repository:

```text
Using deepwiki, how does the React reconciler schedule work?
```

The agent calls the DeepWiki tools, reads the indexed documentation for
`facebook/react`, and answers in the same turn — without cloning the repo.

## What it does

DeepWiki is a thin Claude Code plugin that wires up Cognition AI's hosted
[DeepWiki MCP server](https://docs.devin.ai/work-with-devin/deepwiki-mcp).
It gives your agent read-only access to auto-generated documentation and Q&A
over public GitHub repositories.

Use it when you want to:

- Understand an unfamiliar codebase before adopting or contributing to it
- Answer questions about a dependency without leaving your session
- Pull architecture and API context into a task without cloning gigabytes of source

Any public repo at `github.com/<owner>/<repo>` is reachable. DeepWiki indexes it
and serves the documentation; this plugin lets the agent query it programmatically.

## Features

| Feature | Detail |
| --- | --- |
| Marketplace install | One command via the [88plug marketplace](https://github.com/88plug/claude-code-plugins) |
| No API key | No local process, no manual MCP config |
| Remote MCP | Connects to `https://mcp.deepwiki.com/mcp` over HTTP |
| Read-only | The agent reads docs and asks questions — nothing more |
| Any public GitHub repo | Works against `github.com/<owner>/<repo>` |

## MCP tools

The plugin exposes one MCP connection named `deepwiki`:

| Tool | What it does |
| --- | --- |
| `read_wiki_structure` | List the auto-generated documentation pages for a repository |
| `read_wiki_contents` | Fetch the full documentation for a repository |
| `ask_question` | Ask a natural-language question about a repository and get an AI-generated answer |

You normally do not call these by hand. Mention `deepwiki` or a repository in
your prompt and the agent selects the right tool.

## Remote service

!!! note
    This plugin is configuration only. The indexing, the model, and the served
    documentation are operated by [Cognition AI](https://cognition.ai) (the team
    behind Devin) at `https://mcp.deepwiki.com/mcp`. 88plug does not run the
    underlying service. When the agent queries DeepWiki, your query text is sent
    to that endpoint; the plugin does not proxy or log anything. Only public
    repositories are indexed, so do not send private repository names.

!!! tip
    If the upstream endpoint changes or goes down, open
    [`.claude-plugin/plugin.json`](https://github.com/88plug/deepwiki/blob/main/.claude-plugin/plugin.json)
    and update the MCP URL. This plugin is just config — no original business logic.

## Contributing

Issues and pull requests are welcome at
[88plug/deepwiki](https://github.com/88plug/deepwiki). Keep changes small; the
plugin is intentionally a thin wrapper over the remote MCP server.

## License

Released under the
[Functional Source License, Version 1.1, ALv2 Future License](https://github.com/88plug/deepwiki/blob/main/LICENSE)
(`FSL-1.1-ALv2`).

You may use, copy, modify, and redistribute it for any purpose except a Competing
Use. Each released version converts to the Apache License 2.0 on the second
anniversary of its release date. For commercial-use inquiries outside the
Permitted Purpose, contact andrew@88plug.com.
