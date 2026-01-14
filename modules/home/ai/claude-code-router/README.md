# Claude Code Router quick guide

Use this config to route Claude Code through different providers. Keep the file as plain JSON (no comments); edit provider blocks and restart `ccr` after changes.

## Openrouter
Config snippet
```json
"Providers": [
  {
    "name": "openrouter",
    "api_base_url": "https://openrouter.ai/api/v1/chat/completions",
    "api_key": "YOUR_KEY",
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
Notes
- Built-in openrouter transformer works as-is; no extra plugins needed.

## Z.AI
Config snippet
```json
"Providers": [
  {
    "name": "zai",
    "api_base_url": "https://api.z.ai/api/anthropic/v1/messages",
    "api_key": "YOUR_ZAI_KEY",
    "models": ["glm-4.6", "glm-4.5", "glm-4.5-air"],
    "transformer": {
      "use": ["Anthropic"]
    }
  }
]
```
Notes
- The Anthropic transformer works with the `/anthropic/v1/messages` endpoint.
- The dabstractor z-ai transformer is currently not working here.
- Optional add-ons like `enhancetool` or `chutes-glm` are not required.



## Gemini CLI
Config stub (not yet working)
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

Transformer plugins (toggle by swapping path to the variant you want to test)
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


Status
- References:
  - https://gist.github.com/musistudio/1c13a65f35916a7ab690649d3df8d1cd
  - https://github.com/dabstractor/ccr-integrations/blob/main/gemini-cli.js
- Two variants exist in the references above; switch the `path` to point at the plugin you want to try under `~/.claude-code-router/plugins/`.
