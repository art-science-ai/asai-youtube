# Presentation on AI to Cogitaas

## Overview
- Understand the science of how AI works and the art of using AI to re-imagine your life, business, and society. 
- This presentation covers AI's evolution from ancient dreams to modern generative models, practical applications in business analytics, and specific implementation strategies for Cogitaas' CPG consulting work. 


## Working with marp presentation
Preview presentation:
```sh
marp -p presentation.md 
marp -p presentation.md --theme-set 
```
Problem: Sometimes changes to the presentation don't get rendered in the preview, and I need to kill and rerun the CLI


## Working with images and SVGs

- SVGs can be generated programmatically from images:
```sh
nix shell nixpkgs#vtracer
vtracer --input assets/ai-rules-ml.webp --output assets/vtracer-ai-rules-ml.svg
```
- However, these SVGs are not human readable or understandable. Instead we can ask an LLM to generate a more readable svg like `assets/ai-ml-circles/gemini-cli.svg`
