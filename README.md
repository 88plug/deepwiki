# deepwiki

[![license](https://img.shields.io/badge/license-FSL--1.1--ALv2-000?style=for-the-badge)](./LICENSE.md)
[![marketplace](https://img.shields.io/badge/install-88plug-000?style=for-the-badge)](https://github.com/88plug/claude-code-plugins)
[![Ask DeepWiki](https://deepwiki.com/badge.svg)](https://deepwiki.com/88plug/deepwiki)

A thin Claude Code plugin that wires up [Cognition AI's hosted DeepWiki MCP
server](https://docs.devin.ai/work-with-devin/deepwiki-mcp). Once installed,
your agent can read auto-generated documentation for any public GitHub repo
without cloning it.

## Install

```sh
/plugin marketplace add 88plug/claude-code-plugins
/plugin install deepwiki@88plug
```

That's it. No API key, no local server, no config. The plugin declares the
remote MCP endpoint and Claude Code connects to it over SSE.

## What you get

A Claude Code MCP connection named `deepwiki` exposing tools like:

- `ask_question` — chat with any GitHub repo's documentation
- `read_wiki_structure` — list the auto-generated pages for a repo
- `read_wiki_contents` — fetch a specific page

URL pattern: `deepwiki.com/<owner>/<repo>` works for any public GitHub repo.
The MCP server lets the agent query it programmatically.

## What this plugin is, and what it isn't

**Is:** a 30-line plugin manifest that registers the remote MCP endpoint
hosted by Cognition AI at `https://mcp.deepwiki.com/sse`. Zero original
business logic.

**Is not:** the DeepWiki service itself. The actual indexing, the LLM, and
the served documentation are operated by [Cognition
AI](https://cognition.ai) (the team behind Devin). If their endpoint goes
down or changes, this plugin is just config — open the manifest, swap the
URL.

## Privacy

When the agent queries DeepWiki, query text is sent to
`mcp.deepwiki.com`. The plugin does not proxy or log anything. Don't query
private repo names through this; only public repos are indexed by DeepWiki
anyway.

## Why this exists

DeepWiki has an [MCP server](https://docs.devin.ai/work-with-devin/deepwiki-mcp),
but configuring a remote MCP server manually in `~/.claude/.mcp.json` is
fiddly. This plugin makes it a single `/plugin install` command, discoverable
through the 88plug marketplace alongside other tools.

## License

[Functional Source License, Version 1.1, ALv2 Future License](LICENSE.md)
(`FSL-1.1-ALv2`).

Free to use, copy, modify, and redistribute for any purpose *except* a
Competing Use. Each released version automatically converts to the Apache
License 2.0 on the second anniversary of its release date.

For commercial-use inquiries that fall outside the Permitted Purpose:
claude@cryptoandcoffee.com.
