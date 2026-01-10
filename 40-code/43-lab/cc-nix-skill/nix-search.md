# Nix Search Guide for Technical Users

A concise guide to finding packages, options, and files in the Nix ecosystem using command-line tools.

## Overview

Searching in the Nix ecosystem can be split into three main categories:

1. **Packages**: Finding software to install
   - Applications: `firefox`, `vscode`, `spotify`
   - Development tools: `python`, `nodejs`, `gcc`, `git`
   - Libraries: `openssl`, `zlib`, `boost`
   - System utilities: `ripgrep`, `fd`, `htop`

2. **Options**: Finding configuration keys for system setup
   - NixOS services: `services.nginx.enable`, `networking.firewall.enable`
   - Home Manager programs: `programs.zsh.enable`, `programs.git.userName`
   - Desktop environment: `services.xserver.windowManager.i3.enable`
   - System settings: `boot.loader.systemd-boot.enable`, `users.users.<name>`

3. **Files**: Finding which package provides a specific file (reverse search for debugging)
   - Executables: `bin/python`, `bin/cargo`
   - Libraries: `libssl.so`, `libgtk-3.so`
   - Header files: `include/python.h`, `include/openssl/ssl.h`
   - Config files: `share/applications/firefox.desktop`

## Quick Start: 5-Minute Workflow

Most Nix searches fall into these categories:

```bash
# Find a package to install
nix run nixpkgs#nh -- search firefox

# Find which package provides a file
nix run nixpkgs#nix-index -- nix-locate bin/python

# Search configuration options and documentation
nix run nixpkgs#manix -- ssh
```

## Essential Tools (80% of needs)

### nix search - Built-in package search
**What it does**: Searches Nix packages using the built-in Nix command.
**When to use**: First choice for finding packages, works with flakes.
**Try it**: `nix run nixpkgs#nix -- search nixpkgs firefox`
**Usage pattern**: `nix search nixpkgs <package-name>`

### nh search - Faster package search
**What it does**: Optimized package search with caching and better output.
**When to use**: Faster alternative to `nix search`, especially for repeated searches.
**Try it**: `nix run nixpkgs#nh -- search python`
**Usage pattern**: `nh search <package-name>`

### manix - Unified documentation search
**What it does**: Searches NixOS options, Home Manager options, packages, and library functions.
**When to use**: When you don't know if something is a package or configuration option.
**Try it**: `nix run nixpkgs#manix -- nginx`
**Usage pattern**: `manix <search-term>`

### nix-locate - Find which package provides a file
**What it does**: Reverse search to find which package contains a specific file.
**When to use**: Essential for debugging "command not found" or linking errors.
**Try it**: `nix run nixpkgs#nix-index -- nix-locate libssl.so`
**Usage pattern**: `nix-locate <filename-or-path>`

## Specialized Tools (20% of needs)

### nps - Offline cached searches
**What it does**: Caches package lists locally for ultra-fast relevance-ranked searches.
**When to use**: Offline workflows or when you need very fast repeated searches.
**Try it**: `nix run nixpkgs#nps -- git`
**Usage pattern**: `nps <search-term>`

### nix-search-cli - Web backend CLI
**What it does**: CLI interface for search.nixos.org with detailed filters.
**When to use**: When you need advanced filters (version, installed programs) and have internet.
**Try it**: `nix run nixpkgs#nix-search-cli -- --program go`
**Usage pattern**: `nix-search --filter <value> <query>`

### nix-tree - Dependency visualization
**What it does**: Interactive dependency graph viewer for Nix store.
**When to use**: Understanding why a package is installed or dependency relationships.
**Try it**: `nix run nixpkgs#nix-tree`
**Usage pattern**: `nix-tree` (interactive)

### nix-doc - Function documentation
**What it does**: Search Nix library functions and generate code tags.
**When to use**: Writing Nix code and need function signatures and documentation.
**Try it**: `nix run nixpkgs#nix-doc -- search mapAttrs`
**Usage pattern**: `nix-doc search <function-name>`

## Decision Guide: When to Use What

### I want to find a package to install
**First choice**: `nh search <package>` (faster, better output)
**Alternative**: `nix search nixpkgs <package>` (built-in, no extra tool)

### I need to find which package has a specific file
**Use**: `nix-locate <filename>`
**Example**: `nix-locate bin/vim` finds which package provides the `vim` binary

### I'm looking for configuration options
**Use**: `manix <option-name>`
**Example**: `manix networking` finds all networking-related options

### I need library function documentation
**Use**: `nix-doc search <function>` or `manix <function>`
**Example**: `nix-doc search foldl` shows function signature and docs

### I work offline frequently
**Use**: `nps <search-term>` after initial cache generation
**Benefit**: All searches work offline after first run

### I need advanced package filters
**Use**: `nix-search-cli --filter <value> <query>`
**Example**: `nix-search --version 1.20 python` finds Python 1.20.x

### I want to understand package dependencies
**Use**: `nix-tree` (interactive exploration)
**Benefit**: Visual dependency graph with store paths

## Performance Tips

- **First-time setup**: `nix-index` and `nps` require initial indexing
- **Internet required**: `nix-search-cli` only
- **Offline capable**: `nix search`, `nh`, `manix`, `nix-locate` (after indexing), `nps` (after caching)
- **Fastest for repeated searches**: `nps` (cached), `nh search` (optimized)

## Common Workflows

### Find and install a package
```bash
# Search for the package
nix run nixpkgs#nh -- search firefox

# Install it (example for NixOS)
nix-env -iA nixpkgs.firefox
```

### Debug missing command
```bash
# Find which package provides the command
nix run nixpkgs#nix-index -- nix-locate bin/htop

# Install the found package
nix-env -iA nixpkgs.htop
```

### Configure system service
```bash
# Find configuration options
nix run nixpkgs#manix -- nginx

# Use the found options in configuration.nix
services.nginx.enable = true;
```