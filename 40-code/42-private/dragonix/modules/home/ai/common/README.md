# Common AI Configuration

Shared documentation and configuration for all AI tools.

## Files

- `AGENTS.md` - AI agent rules and guidelines
- `default.nix` - Common configuration entry point

## AGENTS.md Contents

Guidelines for AI agents including:

- General guidelines (README.md, AGENTS.md, CONTRIBUTING.md)
- Markdown formatting rules
- Nix usage patterns
- Python development with uv
- Script examples and best practices

## Usage

This module is automatically imported by the main AI module and provides:

- Shared documentation for all AI tools
- Common agent behavior guidelines
- Standardized formatting and development practices

## Import

```nix
# In your home or host configuration
imports = [ ../../modules/home/ai/common ];
```

Or include via main AI module:

```nix
imports = [ ../../modules/home/ai ];
```