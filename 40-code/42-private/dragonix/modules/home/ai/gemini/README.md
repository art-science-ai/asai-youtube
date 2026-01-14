# Gemini CLI Configuration

Declarative home-manager configuration for Gemini CLI AI assistant.

## Files

- `gemini-cli.nix` - Main configuration module
- `commands/` - Custom command definitions
  - `gh-commit.toml` - Git commit creation command
  - `gh-issue.toml` - GitHub issue creation command

## Configuration

- Editor: Helix (`hx`)
- Vim mode: Enabled
- Theme: GitHub
- Authentication: OAuth personal access token

## Usage

Enable this module by importing it in your home-manager configuration:

```nix
imports = [ <nix-config>/modules/home/ai/gemini ];
```

Or enable via the main AI module (currently commented out):

```nix
imports = [ <nix-config>/modules/home/ai ];
```

## Commands

- `/gh-commit` - Create descriptive git commits
- `/gh-issue` - Create well-structured GitHub issues

## Notes

- `google_accounts.json` must be manually symlinked from dotfiles
- Commands reference the shared AGENTS.md documentation