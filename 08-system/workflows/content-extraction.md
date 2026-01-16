---
global-type: misc-workflows
workflow-implementation: ai-agent
workflow-inputs: url
workflow-outputs: source-note
---
## Usage
Using via AI CLIs

```bash
## Claude Code - Interactive
claude
@web-content-extractor SOURCE_URL

## Claude Code - Headless
claude -p "use web-content-extractor agent to extract SOURCE_URL" --dangerously-skip-permissions --verbose

## Gemini CLI - Interactive
gemini
Extract SOURCE_URL by following the instructions in @web-content-extractor

## Gemini CLI - Headless
cat .claude/agents/web-content-extractor.md | gemini -p "SOURCE_URL" -y

## Opencode - Interactive
opencode
@web-content-extractor SOURCE_URL

## Opencode - Headless
opencode run "SOURCE_URL" --model "opencode/grok-code" --agent "web-content-extractor"
```