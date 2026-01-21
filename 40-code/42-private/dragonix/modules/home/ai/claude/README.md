# Claude Code Configuration

Declarative home-manager configuration for Claude Code AI assistant.

## Files

- `claude.nix` - Main configuration module
- `statusline.py` - Python statusline script for displaying model, directory, and git info
- `statusline.sh` - Bash statusline script with system information
- `CLAUDE.md` - Documentation symlink to shared AGENTS.md

## Configuration

### Settings Management
- `settings.json` is managed as a mutable file using `mkOutOfStoreSymlink`
- Allows Claude Code to modify its configuration while keeping the base file in the module
- Located at: `~/.claude/settings.json` → symlink to module's `settings.json`
- Uses absolute path to ensure clean, direct symlink without Nix store complexity
- Placed in Claude's expected location for maximum compatibility
- Base configuration managed within module for version control

### Settings Architecture
Global settings (`~/.claude/settings.json`) contain user-wide preferences:
- Hooks (langfuse tracing)
- Status line configuration
- Output style and thinking mode

Project-specific settings are managed per-project in `.claude/settings.local.json`:
- Sandbox configuration
- Permissions (allow/deny rules)
- Enabled plugins
- Environment variables

See [Sandboxing documentation](https://code.claude.com/docs/en/sandboxing) for configuration options.

### Statusline Scripts
- Both Python and Bash statusline scripts are managed declaratively
- Made executable and placed in `~/.claude/`
- Configured in Claude settings to provide session information

### Documentation
- `CLAUDE.md` symlinks to shared `AGENTS.md` documentation
- Provides consistent AI agent rules across all tools

## Usage

Enable this module by importing it in your home-manager configuration using relative paths:

```nix
# In home/<user>-<hostname>.nix or similar
imports = [ ../../modules/home/ai/claude ];
```

Or enable via the main AI module:

```nix
imports = [ ../../modules/home/ai ];
```

## Statusline Features

### Python Statusline (`statusline.py`)
- Shows model name in brackets: `[Claude Sonnet 4.5]`
- Displays current directory with folder icon: `📁 directory_name`
- Shows git branch when in a repository: `| 🌿 branch_name`
- Format: `[Model] 📁 directory | 🌿 branch`

### Bash Statusline (`statusline.sh`)
- Shows user@hostname format
- Indicates nix shell environment: `[nix]`
- Displays shell type and current directory
- Shows Claude model information
- Format: `user@hostname [nix] shell dir │ model`

## Notes

- Plugin registry files (`installed_plugins.json`, `known_marketplaces.json`) are ignored as they're managed by Claude Code
- Cache files (`stats-cache.json`, `plans/`) are ignored as they're temporary state
- Settings remain mutable to preserve Claude's ability to update configuration
- Statusline scripts are now under declarative control