# AI Tools Configuration

This directory contains declarative configurations for various AI-powered development tools.

## Structure

- `claude/` - Claude Code configuration and statusline scripts
- `gemini/` - Gemini CLI configuration and commands
- `claude-code-router/` - Claude Code Router setup and plugins
- `opencode/` - OpenCode configuration and themes
- `codex/` - Codex AI assistant configuration
- `common/` - Shared documentation and agent rules

## Usage

Modules are imported in your host or home configuration files using relative paths. For example, in a host configuration:

```nix
# In hosts/<hostname>/default.nix or home/<user>-<hostname>.nix
imports = [
  ../../modules/home/ai
];
```

Or import individual AI tools:

```nix
imports = [
  ../../modules/home/ai/claude
  ../../modules/home/ai/opencode
  ../../modules/home/ai/codex
];
```

## Module Details

### Claude Code
- Location: `claude/`
- Status: Active
- Features: Claude Code AI assistant with statusline scripts
- Configuration: Mutable settings via mkOutOfStoreSymlink, declarative statusline scripts
- Settings Location: `~/.claude/settings.json` → `~/.config/nix-config/modules/home/ai/claude/settings.json`

### Gemini CLI
- Location: `gemini/`
- Status: Available but commented out in main import
- Features: Command-line AI assistant with custom commands
- Commands: GitHub commit and issue creation helpers

### Claude Code Router
- Location: `claude-code-router/`
- Status: Active
- Features: Routes between different AI models and services
- Plugins: Various integrations including Gemini CLI and web search

### OpenCode
- Location: `opencode/`
- Status: Active
- Features: AI-powered code editor and assistant
- Theme: Catppuccin theme configuration
- Plugins: OpenAI Codex auth and skills

### Codex
- Location: `codex/`
- Status: Active
- Features: AI code completion and assistance
- Model: GPT-5.1 Codex Max

### Common
- Location: `common/`
- Status: Active
- Features: Shared documentation and agent rules
- Content: AGENTS.md with guidelines for all AI tools