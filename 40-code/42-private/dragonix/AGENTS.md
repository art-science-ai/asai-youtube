# AI Agent Guidelines for Dragonix

This document provides comprehensive guidelines for AI agents working in the Dragonix repository - a declarative NixOS and macOS configuration system.

## Repository Overview

Dragonix manages complete system configurations for multiple hosts using:
- **NixOS** for Linux servers/desktops
- **nix-darwin** for macOS systems
- **home-manager** for user environments
- **Flakes** for reproducible builds
- **SOPS** for encrypted secrets

## Build/Test Commands

### Core Validation Commands
- `just nh-check` - Check all flake configurations (fast validation)
- `just check-all-dry` - Dry-run check all configurations without building
- `just check <platform> <host>` - Check specific configuration (e.g., `just check x86_64-linux vermax`)
- `just nh-update` - Update all flake inputs and lockfile

### Build Commands
CRITICAL: Never run build commands unless the user explicitly asks for that. Just run validation commands instead.

- `just nh-home` - Switch Home Manager configuration (auto-detects based on user@hostname)
- `just nh-darwin` - Switch Darwin (macOS) system configuration
- `just nh-os` - Switch NixOS system configuration
- `just nh-clean` - Clean Nix store and user profile

### Platform-Specific Builds
- Darwin: `just darwin <host>` - Deploy Darwin system and home (e.g., `just darwin meleys`)
- NixOS Local: `just nixos <host>` - Deploy NixOS system and home locally (e.g., `just nixos vermax`)
- NixOS Remote: `just nixos-ssh <host>` - Deploy NixOS via SSH to remote host

### Individual Configuration Checks
- `just check-meleys` - Check meleys (macOS) configurations
- `just check-moondancer` - Check moondancer (macOS) configurations
- `just check-seasmoke` - Check seasmoke (NixOS) configurations
- `just check-vermax` - Check vermax (NixOS) configurations

### Testing a Single Configuration
To test a specific configuration before applying:
```bash
# Check specific system config
nix build .#checks.x86_64-linux.vermax-config --no-link

# Check specific home config
nix build .#checks.x86_64-linux.home-vermax --no-link
```

## Code Style Guidelines

### Nix Language Conventions

#### File Structure and Comments
- Start files with descriptive comments explaining purpose
- Use single-line comments for implementation details
- Use block comments sparingly, prefer descriptive variable names

#### Imports and Module Structure
```nix
# Good: Clear separation of concerns
{
  imports = [
    ./base.nix
    ./auth
    ./themes
  ];

  # Configuration follows imports
  config = {
    # Options here
  };
}
```

#### Naming Conventions
- Use `camelCase` for variable names and attributes
- Use `kebab-case` for file names
- Use descriptive names: `isDesktop`, `enableAudio`, not `desktop`, `audio`
- Prefix boolean options with `enable`, `disable`, or state verbs: `isEnabled`, `hasFeature`

#### Indentation and Formatting
- Use 2 spaces for indentation (follows nixfmt-rfc-style)
- Align similar structures vertically
- Break long lines appropriately
- Use consistent spacing around operators

#### Attribute Sets
```nix
# Good: Consistent formatting
{
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    vim
    git
    curl
  ];
}
```

#### Functions and Let Expressions
```nix
# Good: Clear variable scoping
let
  isLinux = lib.hasSuffix "-linux" system;
  isDarwin = lib.hasSuffix "-darwin" system;
  desktopModules = [
    ./desktop
    ./themes
  ];
in {
  imports = [
    ./base
  ] ++ lib.optional isDarwin ./darwin
    ++ lib.optional isLinux ./linux
    ++ lib.optionals config.isDesktop desktopModules;
}
```

#### String Handling
- Use double quotes for single-line strings
- Use double single-quotes for multi-line strings
- Prefer `${variable}` interpolation over concatenation

### Module Organization

#### Options Definition
```nix
# Good: Clear option definitions with descriptions
options = {
  isDesktop = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Whether this is a desktop configuration";
  };

  theme = lib.mkOption {
    type = lib.types.enum [ "dark" "light" ];
    default = "dark";
    description = "UI theme variant";
  };
};
```

#### Conditional Logic
- Use `lib.optional` for single conditional imports
- Use `lib.optionals` for multiple conditional imports
- Prefer declarative conditionals over imperative if/then

#### Platform Detection
```nix
# Good: Platform-agnostic code
{ config, lib, system, ... }:
let
  isLinux = lib.hasSuffix "-linux" system;
  isDarwin = lib.hasSuffix "-darwin" system;
in {
  # Use platform flags instead of direct system checks
}
```

### Home Manager Configurations

#### User-Host Pair Structure
```nix
# Good: Self-contained configuration
{
  imports = [
    ../modules/home/base.nix
    ../modules/home/shell-config.nix
    ../modules/home/desktop-apps.nix
  ];

  # Identity
  home.username = "nikhilmaddirala";
  home.homeDirectory = "/Users/nikhilmaddirala";
  home.stateVersion = "23.05";

  # Host-specific settings
  isDesktop = true;
}
```

#### Module Composition
- Group related functionality into modules
- Use clear import hierarchies
- Avoid deep nesting of configurations

### Error Handling and Validation

#### Assertion Patterns
```nix
# Good: Clear error messages
assert lib.assertMsg (config.someOption != null)
  "someOption must be set for this configuration";
```

#### Type Safety
- Use appropriate `lib.types` for options
- Provide sensible defaults
- Document type constraints in descriptions

### Security Considerations

#### Secrets Management
- Never commit secrets directly to repository
- Use SOPS for encrypted secrets in `vars/secrets.yaml`
- Reference secrets through the secrets registry
- Test secrets via `/run/secrets/` paths

#### Permission Handling
- Use appropriate file permissions (0400 for secrets)
- Avoid world-readable sensitive files
- Document permission requirements

### Commit Message Conventions

Follow conventional commit format with project-specific scopes:

```
type(scope): description

[optional body]

[optional footer]
```

**Types:**
- `feat`: New feature or module
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style/formatting
- `refactor`: Code restructuring
- `test`: Testing infrastructure
- `chore`: Maintenance tasks

**Scopes:**
- `flake`: Flake.nix changes
- `home`: Home Manager modules
- `hosts`: System configuration modules
- `modules`: Shared modules
- `secrets`: SOPS/secrets changes
- `docs`: Documentation
- `ci`: CI/CD changes

**Examples:**
- `feat(home): add neovim module`
- `fix(hosts/vermax): resolve audio configuration`
- `refactor(modules): consolidate desktop modules`
- `docs(readme): update host management guide`

## Development Workflow

### Adding New Modules
1. Create module in appropriate `modules/` subdirectory
2. Follow established patterns from similar modules
3. Add tests via flake checks
4. Update documentation
5. Test on target platforms

### Configuration Changes
1. Run `just check-all-dry` to validate syntax
2. Test specific configuration with `just check <platform> <host>`
3. Apply changes with appropriate `just` command
4. Verify functionality on target system

### Testing Strategy
- Use flake checks for build validation
- Test on all supported platforms when possible
- Validate secrets access in target environments
- Test user switching between configurations

## Tooling and Dependencies

### Required Tools
- Nix with flakes enabled
- git for version control
- SOPS for secrets management (when handling secrets)
- Age keys for SOPS decryption

### Development Environment
- Use provided devShells: `nix develop .#python` or `nix develop .#node`
- Run format checks: `nix run nixpkgs#nixfmt-rfc-style -- --check .`
- Use `just` for common operations

### CI/CD Integration
- GitHub Actions validate PRs with build checks
- Formatting enforced via `nixfmt-rfc-style`
- Multi-platform testing (Linux/macOS)
- Flake validation on all systems

## Architecture Patterns

### Layered Configuration
Maintain clear separation:
- **Platform** (Darwin/NixOS specifics)
- **Role** (desktop/server)
- **User** (individual preferences)
- **Host** (hardware-specific settings)

### Module Composition
- Prefer composition over monolithic configs
- Use imports for clear dependency chains
- Keep modules focused on single responsibilities
- Enable features via options, not direct configuration

### Reusability
- Design modules to work across platforms when possible
- Use platform detection for conditional logic
- Avoid hardcoded paths and system assumptions
- Document module capabilities and limitations

This document should be updated as new patterns emerge or standards evolve. Always reference existing code for current conventions before making changes.</content>
<parameter name="filePath">/home/nikhilmaddirala/repos/monorepo/40-code/42-private/dragonix/AGENTS.md
