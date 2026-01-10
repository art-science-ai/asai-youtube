# Helper scripts

## Gemini commands
- This script translates all commands from ai-agents/commands into the format for gemini https://github.com/google-gemini/gemini-cli/blob/main/docs/cli/custom-commands.md
- Script always starts by deleting the entire gemini commands dir and recreating everything.

### How to run `gemini-translate-commands.py`

To run this script, ensure you have `uv` installed. Then execute:

```bash
uv run _scripts/gemini-translate-commands.py
```