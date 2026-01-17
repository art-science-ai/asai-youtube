---
tags: [software, tool, observability, ai]
status: active # exploring, active, archived
type: service # cli, gui, service, library
---

# Langfuse

> **TL;DR:** Open-source LLM engineering platform providing observability, tracing, and analytics for AI applications including Claude Code sessions and custom agents built with Claude Agents SDK.

## Overview
- **Source:** [GitHub](https://github.com/langfuse/langfuse) | [Official Site](https://langfuse.com)
- **Category:** Observability Platform / SaaS Service
- **Key Features:**
    - Detailed trace capture of LLM conversations, tool calls, and responses
    - Cost and token usage tracking across multiple LLM providers
    - Session grouping for multi-turn conversations
    - Prompt management and versioning
    - Evaluation framework with custom metrics
    - Self-hosted or cloud deployment options (EU/US regions)
    - OpenTelemetry-based integration architecture

## Personal context
- **Why / how I am using / considering using this:**
    - Debugging and monitoring Claude Code agentic workflows to understand tool usage patterns
    - Tracking LLM costs and token usage across different projects
    - Building datasets from production traces for evaluation and fine-tuning
- **Projects / hosts in which I am using it:**
    - This monorepo (Claude Code tracing enabled)
    - Future: Custom agent applications using Claude Agents SDK

## Implementation status

- ✅ **Claude Code tracing:** Fully implemented and active
    - Global hook configured via Nix (declarative, reproducible)
    - Enabled for this monorepo with debug logging
    - Traces appear at https://us.cloud.langfuse.com
- ⏳ **Agent SDK tracing:** Not yet implemented
    - Documentation reviewed, ready for future implementation
    - See [Langfuse Agent SDK Integration](https://langfuse.com/integrations/frameworks/claude-agent-sdk) when needed

## Setup and configuration

### Claude Code tracing

See [official integration guide](https://langfuse.com/integrations/other/claude-code) for detailed setup instructions. Key points:

- Uses Claude Code's Stop hook to capture conversation transcripts
- Hook script reads `~/.claude/projects/*.jsonl` files and sends traces to Langfuse
- Tracing is opt-in per project via environment variables
- Logs to `~/.claude/state/langfuse_hook.log`

#### My implementation (Nix + uv)

**Hook script with uv inline metadata:**
- Located at `40-code/42-private/dragonix/modules/home/ai/claude/hooks/langfuse_hook.py`
- Uses `#!/usr/bin/env -S uv run --script` with PEP 723 inline dependencies
- No manual installation needed - uv handles langfuse package automatically
- Symlinked to `~/.claude/hooks/langfuse_hook.py` via Nix home-manager

**Nix configuration:**
```nix
# In claude.nix
home.file.".claude/hooks/langfuse_hook.py" = {
  source = ./hooks/langfuse_hook.py;
  executable = true;
};
```

**Global hook registration:**
```json
// ~/.claude/settings.json (symlinked from dragonix config)
{
  "hooks": {
    "Stop": [{"hooks": [{"type": "command", "command": "~/.claude/hooks/langfuse_hook.py"}]}]
  }
}
```

**Per-project tracing:**
```json
// monorepo/.claude/settings.local.json
{
  "env": {
    "TRACE_TO_LANGFUSE": "true",
    "LANGFUSE_PUBLIC_KEY": "pk-lf-...",
    "LANGFUSE_SECRET_KEY": "sk-lf-...",
    "LANGFUSE_HOST": "https://us.cloud.langfuse.com",
    "CC_LANGFUSE_DEBUG": "true"
  }
}
```

**Benefits:** Declarative, reproducible across machines, version-controlled hook script, zero manual setup after home-manager rebuild.

## Usage

**Normal workflow:**
- Use Claude Code as normal - tracing happens automatically in the background
- Hook runs after each response, processing only new conversation turns
- View traces at https://us.cloud.langfuse.com

**Troubleshooting:**
```bash
# Check hook logs
tail -f ~/.claude/state/langfuse_hook.log

# Enable debug mode in .claude/settings.local.json
"CC_LANGFUSE_DEBUG": "true"
```

**What gets traced:**
- User prompts and assistant responses
- All tool calls (Read, Write, Edit, Bash, Grep, etc.) with inputs/outputs
- Session grouping (all turns from same conversation share session_id)
- Timing and performance data
- Model information and token usage

## Alternatives
- **LangSmith:** LangChain-native observability, less flexible outside LangChain
- **Helicone:** Proxy-based, adds latency
- **Weights & Biases:** Heavier, broader ML focus
- **Custom logging:** Lacks visualization and cost tracking

## References
- [Official Documentation](https://langfuse.com/docs)
- [Claude Code Integration Guide](https://langfuse.com/integrations/other/claude-code)
- [Claude Agent SDK Integration](https://langfuse.com/integrations/frameworks/claude-agent-sdk)
- [Anthropic API Integration](https://langfuse.com/integrations/model-providers/anthropic)
- [GitHub Repository](https://github.com/langfuse/langfuse)
- [Python SDK Documentation](https://langfuse.com/docs/sdk/python/decorators)
- [OpenTelemetry Integration](https://langfuse.com/changelog/2025-05-23-otel-based-python-sdk)
