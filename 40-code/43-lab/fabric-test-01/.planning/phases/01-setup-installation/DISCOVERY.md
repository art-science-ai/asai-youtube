# Phase 1: Discovery - Fabric CLI Installation

**Research Date:** 2026-01-10
**Depth:** Standard (15-30 min)
**Status:** Complete

---

## Research Questions

1. What are the current recommended installation methods for Fabric CLI?
2. Does Fabric support nix package manager installation?
3. What are the system requirements and dependencies?
4. How do we verify successful installation?

---

## Findings

### Official Installation Methods

From Fabric's GitHub repository (https://github.com/danielmiessler/fabric):

**1. curl one-liner (recommended for most users):**
```bash
curl -L https://www.fabric.ai/install.sh | sh
```

This script:
- Detects your OS and architecture
- Downloads the appropriate binary
- Installs to `/usr/local/bin` (or adds to PATH)
- Works on Linux, macOS, and WSL

**2. Homebrew (macOS/Linux):**
```bash
brew install fabric
```

**3. Go install (if Go is installed):**
```bash
go install github.com/danielmiessler/fabric@latest
```

**4. Docker:**
```bash
docker pull danielmiessler/fabric
```

### Nix Package Status

**Finding:** Fabric IS available in nixpkgs as `fabric-ai` package with Home Manager module support.

**Nix installation options:**

1. **Imperative (nix-env):**
```bash
nix-env -iA nixpkgs.fabric-ai
```

2. **Declarative (configuration.nix or flake):**
```nix
environment.systemPackages = with pkgs; [
  fabric-ai
];
```

3. **Home Manager (recommended for user-level setup):**
```nix
programs.fabric-ai = {
  enable = true;
  enableBashIntegration = true;  # or enableZshIntegration
  enablePatternsAliases = true;
  enableYtAlias = true;
};
```

**Home Manager options:**
- `programs.fabric-ai.enable` - Enable Fabric AI
- `programs.fabric-ai.enableBashIntegration` - Bash shell integration
- `programs.fabric-ai.enableZshIntegration` - Zsh shell integration
- `programs.fabric-ai.enablePatternsAliases` - Aliases for all patterns
- `programs.fabric-ai.enableYtAlias` - YouTube alias
- `programs.fabric-ai.package` - Custom package (defaults to pkgs.fabric-ai)

### System Requirements

**Dependencies:**
- No strict dependencies for the binary installation
- API keys required for actual usage (OpenAI, Claude, etc.) - but not for installation
- Git (if using patterns from GitHub)

**Platform support:**
- Linux (x86_64, arm64)
- macOS (Intel, Apple Silicon)
- WSL on Windows

### Verification Commands

```bash
# Check installation
fabric --version

# List available patterns
fabric --listpatterns

# Get help
fabric --help
```

---

## Decision Points

### Installation Method Selection

Given CONTEXT.md requirements:
- **Linux:** nix preferred → **use `nix-env -iA nixpkgs.fabric-ai`** (imperative) or Home Manager (declarative)
- **macOS:** nix preferred, homebrew fallback → **nix first, `brew install fabric` as fallback**

**Rationale:** Fabric is available in nixpkgs as `fabric-ai` with full Home Manager support. This aligns perfectly with the user's nix-first preference and provides better reproducibility than the curl installer.

### Documentation Strategy

From CONTEXT.md:
- Location: README.md (not separate SETUP.md)
- Content: Commands run + key decisions explained
- Platforms: Linux + macOS
- Methods: curl (primary), homebrew (macOS fallback)

---

## Installation Commands to Document

**Linux (via nix - imperative):**
```bash
nix-env -iA nixpkgs.fabric-ai
```

**Linux/macOS (via nix - Home Manager declarative):**
```nix
programs.fabric-ai = {
  enable = true;
  enableBashIntegration = true;
  enablePatternsAliases = true;
};
```

**macOS (via homebrew - fallback if nix not available):**
```bash
brew install fabric
```

**Verification:**
```bash
fabric --version
```

---

## Risks & Considerations

**Low Risk:**
- Fabric is in stable nixpkgs, actively maintained
- Home Manager module provides excellent integration options
- Multiple installation methods provide flexibility

**Considerations:**
- Nix installation requires nix to be set up (prerequisite)
- Home Manager requires Home Manager to be configured
- For users without nix/Home Manager, homebrew (macOS) or curl (any) are alternatives
- API key configuration happens post-installation (out of scope for this phase)

---

## Next Steps

1. Install Fabric CLI using nix: `nix-env -iA nixpkgs.fabric-ai`
2. Verify installation with `fabric --version`
3. Document the process in README.md Setup section
4. Include both nix (primary) and homebrew (macOS fallback) methods
5. Explain key decisions (why nix, Home Manager options noted)

---

*Discovery complete. Ready for planning.*
