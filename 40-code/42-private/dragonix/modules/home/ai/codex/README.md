# Codex Configuration

Declarative home-manager configuration for Codex AI assistant.

## Files

- `codex.nix` - Main configuration module

## Configuration

- Model: GPT-5.1 Codex Max
- Trusted project: `/Users/nikhilmaddirala/repos`
- Migration prompt: Hidden for GPT-5.1 Codex Max

## Usage

Enable this module by importing it in your home-manager configuration:

```nix
imports = [ <nix-config>/modules/home/ai/codex ];
```

Or enable via the main AI module:

```nix
imports = [ <nix-config>/modules/home/ai ];
```

## Notes

- Codex provides AI-powered code completion and assistance
- Configuration is minimal with focus on model selection and project trust