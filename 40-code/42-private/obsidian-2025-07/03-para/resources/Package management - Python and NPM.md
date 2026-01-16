
## Overview

Managing NPM and Python packages within Nix + home-manager on macOS presents challenges: language-specific package managers don't integrate cleanly with Nix, especially for packages not in nixpkgs. This document evaluates approaches for declaratively managing CLI tools while keeping them available for scripts and interactive use.

Key requirements:
- Available in all contexts (login shells, scripts, other tools)
- Latest versions preferred
- Declarative configuration in home-manager

## Package ecosystems

### npm/npx fundamentals
- **npm**: Traditional package installer
	- Config: `~/.npmrc`, check prefix with `npm prefix -g`
	- Global installs: Use configured prefix (set to `~/.npm-global`)
	- Shared global node_modules (potential conflicts)
- **npx**: Ephemeral package runner
	- Cache: `~/.npm/_npx`
	- Runs packages without persistent install
	- Sometimes creates global packages as side effect

### uv/uvx fundamentals
- **uv**: Fast Rust-based Python package manager
	- Config: `~/.config/uv/`
	- `uv tool install`: Persistent, isolated venv per tool
	- Default locations (configurable via environment variables):
		- Tool venvs: `~/.local/share/uv/tools/` (UV_TOOL_DIR)
		- Executables: `~/.local/bin/` (UV_TOOL_BIN_DIR)
	- 10-100x faster than pip
- **uvx**: Ephemeral package runner (Python's npx)
	- Cache: `~/.cache/uv/`
	- Runs packages without persistent install

### Key differences

| Aspect | NPM | Python (uv) |
|--------|-----|-------------|
| Ephemeral runner | npx | uvx |
| Persistent install | npm -g (shared) | uv tool install (isolated venvs) |
| Speed | Slower | Very fast (Rust-based) |
| Isolation | Shared global directory | Separate venv per tool |
| Conflict risk | Higher | Lower |

## The Nix integration problem

Language package managers expect to manage their own directory structures and update mechanisms, which conflicts with Nix's functional package management:

- **Declarative config**: Want packages defined in home-manager, but language managers use imperative install commands
- **Build tools**: Some packages need compilers/build tools during installation, not available in home-manager activation context
- **Latest versions**: Want latest packages, but Nix prefers pinned hashes
- **Script availability**: Shell aliases don't work for non-interactive contexts

## Solution options

**Option 1: Shell aliases with ephemeral runners**
- Use aliases like `claude = "npx -y @anthropic-ai/claude-code@latest"`
- Pros: Simple, always latest, no persistent installs
- Cons: **Doesn't work for scripts/tools** (aliases not available), network dependency

**Option 2: Activation script installs**
- Run `npm install -g` or `uv tool install` in home-manager activation script
- Pros: Declarative list, automatic on home-manager switch
- Cons: **Missing build tools in activation context** (some packages fail), especially for NPM
- **Option 2a (Hybrid)**: Activation creates update script but doesn't run it
	- Activation generates script with package list from Nix config
	- Run script manually in full user environment when needed
	- Example: activation writes `~/.local/bin/update-tools.sh` with install commands
	- Pros: Declarative list in Nix, full environment when executed, single source of truth
	- Cons: Still manual execution step (but script stays in sync with config)

**Option 3: Nix wrapper derivations**
- Create Nix packages that wrap npx/uvx calls
- Install wrappers to PATH
- Pros: Works everywhere, declarative, always latest
- Cons: Network dependency, cache complexity, indirection

**Option 4: Manual update script** ⭐
- Maintain script listing packages to install
- Run manually when updates needed
- For NPM: `npm install -g package1 package2...`
- For Python: `uv tool install package1; uv tool install package2...`
- Pros: Works everywhere, explicit control, **Python: very fast and isolated venvs**
- Cons: Two-step process (not automatic with home-manager switch)
- **Python advantage**: uv's speed makes this painless; isolated venvs prevent conflicts

**Option 5: Full Nix packaging (node2nix/poetry2nix)**
- Package each tool as proper Nix derivation
- Pros: Pure Nix, reproducible
- Cons: Manual hash updates, complex for packages with many dependencies

**Option 6: Hybrid approach**
- Use activation script for packages that work
- Manual approach for problematic packages
- Pros: Maximizes automation where possible
- Cons: Inconsistent package handling

**Option 7: Background service (systemd/launchd)**
- Service installs packages in full user context
- Pros: Declarative, proper environment, async
- Cons: Complex setup, timing issues

## Current decisions

**NPM**: Under evaluation - leaning toward Option 2a (activation-generated script) or Option 4 (manual script)
- Need solution that works for scripts while maintaining declarative package list
- Option 2a provides best balance: declarative config, full environment when run

**Python**: Option 2a or Option 4 recommended
- uv's speed (10-100x faster) makes manual updates trivial
- Isolated venvs prevent conflicts that plague npm global installs
- Option 2a keeps package list in Nix config while avoiding activation context issues

## Appendix

### Use cases
- **NPM**: Claude Code, Opencode, Gemini CLI
- **Python**: yt-dlp, pypdf, ruff, black, playwright

### Useful commands

NPM:
- Check prefix: `npm prefix -g`
- List globals: `npm list -g --depth=0`
- Clear npx cache: `rm -rf ~/.npm/_npx`

Python (uv):
- List tools: `uv tool list`
- Install tool: `uv tool install <package>`
- Update tool: `uv tool upgrade <package>`
- Uninstall: `uv tool uninstall <package>`
- Run ephemeral: `uvx <package> <args>`

### Resources
- [uv documentation](https://github.com/astral-sh/uv)
- [Nix home-manager manual](https://nix-community.github.io/home-manager/)
