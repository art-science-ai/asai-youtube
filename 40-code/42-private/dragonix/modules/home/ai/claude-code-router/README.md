# Claude Code Router quick guide

Use this config to route Claude Code through different providers.

## Known issues

This module is currently disabled. Before re-enabling, fix the following:

- Home-manager file management conflict: The module changed from managing the entire `~/.claude-code-router/` directory as a single symlink to managing individual files within it. This causes activation failures because home-manager cannot create symlinks inside a read-only Nix store path.
- To fix: Either revert to whole-directory management, or require users to manually remove `~/.claude-code-router` before first activation with the new strategy.
- Manual cleanup before re-enabling: `rm ~/.claude-code-router`

## Secrets management

API keys are managed via sops-nix and injected at runtime using `envsubst`.

How it works:
- `config.template.json` contains `$OPENROUTER_API_KEY` and `$ZAI_API_KEY` placeholders
- The `ccr` wrapper script runs `envsubst` to generate `config.json` with actual values
- Environment variables are loaded from `/run/secrets/` via the shell secret loader

To update API keys:
```bash
cd ~/repos/monorepo/40-code/42-private/dragonix/vars
sops secrets.yaml  # Edit openrouter/api_key or zai/api_key
```

After updating secrets, restart your shell or run `ccr` again.

## Providers

### Openrouter

Config snippet:
```json
"Providers": [
  {
    "name": "openrouter",
    "api_base_url": "https://openrouter.ai/api/v1/chat/completions",
    "api_key": "$OPENROUTER_API_KEY",
    "models": [
      "x-ai/grok-code-fast-1",
      "x-ai/grok-4.1-fast:free",
      "google/gemini-2.5-pro-preview"
    ],
    "transformer": {
      "use": ["openrouter"]
    }
  }
]
```

Notes:
- Built-in openrouter transformer works as-is; no extra plugins needed.

### Z.AI

Config snippet:
```json
"Providers": [
  {
    "name": "zai",
    "api_base_url": "https://api.z.ai/api/anthropic/v1/messages",
    "api_key": "$ZAI_API_KEY",
    "models": ["glm-4.6", "glm-4.5", "glm-4.5-air"],
    "transformer": {
      "use": ["Anthropic"]
    }
  }
]
```

Notes:
- The Anthropic transformer works with the `/anthropic/v1/messages` endpoint.
- The dabstractor z-ai transformer is currently not working here.
- Optional add-ons like `enhancetool` or `chutes-glm` are not required.

### Gemini CLI

Config snippet:
```json
"Providers": [
  {
    "name": "gemini-cli",
    "api_base_url": "https://cloudcode-pa.googleapis.com/v1internal",
    "api_key": "*",
    "models": ["gemini-2.5-flash"],
    "transformer": {
      "use": ["gemini-cli"]
    }
  }
]
```

Transformer plugins (toggle by swapping path to the variant you want to test):
```json
"transformers": [
  {
    "path": "~/.claude-code-router/plugins/musistudio-gemini-cli.js",
    "options": { "project": "gen-lang-client-0577327587" }
  }
]
```
Status: working!

```json
"transformers": [
  {
    "path": "~/.claude-code-router/plugins/dabstractor-gemini-cli.js",
    "options": { "project": "gen-lang-client-0577327587" }
  }
]
```

References:
- https://gist.github.com/musistudio/1c13a65f35916a7ab690649d3df8d1cd
- https://github.com/dabstractor/ccr-integrations/blob/main/gemini-cli.js

Two variants exist in the references above; switch the `path` to point at the plugin you want to try under `~/.claude-code-router/plugins/`.
