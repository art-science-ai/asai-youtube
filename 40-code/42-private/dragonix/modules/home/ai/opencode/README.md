# OpenCode Configuration

Declarative home-manager configuration for OpenCode AI-powered development environment.

## Files

- `opencode.nix` - Main configuration module
- `opencode-catppuccin.json` - Catppuccin theme configuration
- `oh-my-opencode.jsonc` - Oh My OpenCode plugin configuration

## Features

- TUI with scroll acceleration
- Auto layout detection
- Catppuccin theme
- OpenAI Codex authentication
- Nix LSP integration
- Custom agent permissions

## Providers

- OpenRouter: General AI models
- OpenAI: GPT-5 and GPT-5 Codex models with reasoning effort control

## Plugins

- `opencode-openai-codex-auth` - OpenAI authentication
- `opencode-skills` - Additional skills and capabilities
- `oh-my-opencode` - Available but commented out

## Usage

Enable this module by importing it in your home-manager configuration using relative paths:

```nix
# In home/<user>-<hostname>.nix
imports = [ ../../modules/home/ai/opencode ];
```

Or enable via the main AI module:

```nix
imports = [ ../../modules/home/ai ];
```

## Configuration

- Theme: Catppuccin (opencode-catppuccin.json)
- Instructions: AGENTS.md
- LSP: Nixd for .nix files
- Agent permissions: Controlled for git, just, nix, and nh commands