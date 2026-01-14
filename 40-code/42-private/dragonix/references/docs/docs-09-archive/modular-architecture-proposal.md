# Modular Architecture Migration Proposal

## Executive Summary

This document outlines the migration from the current monolithic Nix Darwin configuration to a simplified modular architecture. The proposal focuses on clean separation between platform-specific configurations while maintaining the existing functionality and preparing for future expansion.

## Current Architecture Analysis

### Current State
- **File**: Single `flake.nix` (422 lines)
- **Architecture**: Monolithic configuration with embedded Home Manager
- **Platform**: macOS-focused with comprehensive Darwin integration
- **Key Features**:
  - Comprehensive macOS system defaults
  - Integrated Homebrew package management
  - Linux builder VM configuration
  - Custom development shells (Python, Node, temp)
  - Multi-host SSH configuration
  - Advanced system activation scripts

### Current Challenges
1. **Maintainability**: Large single file difficult to navigate and modify
2. **Scalability**: Adding new hosts or users requires editing core flake
3. **Reusability**: Configuration tied to specific user/host combination
4. **Testing**: Changes affect entire system configuration
5. **Collaboration**: Single file creates merge conflicts

## Proposed Modular Architecture

### Simplified Structure Philosophy
The proposed architecture follows a **platform-based organization** principle:
- **hosts/**: System-level configurations organized by platform
- **home/**: User-level configurations organized by platform
- **common/**: Shared configurations across platforms

### Directory Structure
```
nix-config/
├── flake.nix                   # Core flake definition (simplified)
├── flake.lock                  # Dependency locks
├── hosts/                      # Host-specific configurations
│   ├── common/                 # Shared across all host types
│   │   ├── default.nix         # Base system settings (users, nix config)
│   │   └── users.nix           # User definitions
│   ├── mac/                    # Darwin-specific host configuration
│   │   ├── default.nix         # Darwin base configuration
│   │   ├── system-defaults.nix # macOS system preferences
│   │   ├── homebrew.nix        # Homebrew configuration
│   │   └── linux-builder.nix   # Linux builder VM setup
│   └── server/                 # Future Linux server configurations
│       └── default.nix         # Server base configuration
└── home/                       # Home Manager configurations
    ├── common/                 # Cross-platform home configuration
    │   ├── default.nix         # Base home configuration
    │   ├── cli.nix             # CLI tools (git, ssh, starship, etc.)
    │   └── development.nix     # Development environments and shells
    └── mac/                    # macOS-specific home configuration
        ├── default.nix         # macOS home base
        └── apps.nix            # macOS-specific applications and configs
```

## Migration Strategy

### Phase 1: Structure Creation and Core Extraction
**Objective**: Create modular structure and extract core flake configuration

**Tasks**:
1. Create directory structure: `hosts/{common,mac,server}` and `home/{common,mac}`
2. Extract flake.nix core with proper host/home separation
3. Create base configuration files with proper imports

**Expected Duration**: 2-3 hours

### Phase 2: System Configuration Modularization
**Objective**: Move system-level configuration to appropriate modules

**Tasks**:
1. **hosts/common/default.nix**: Extract base system configuration
   - Nix settings and experimental features
   - Basic system packages
   - Common security settings
2. **hosts/common/users.nix**: Extract user definitions
   - User creation and basic settings
   - SSH keys and groups
3. **hosts/mac/default.nix**: Darwin-specific base
   - Darwin system configuration
   - Platform-specific settings
4. **hosts/mac/system-defaults.nix**: macOS system preferences
   - Dock, Finder, trackpad settings
   - Keyboard and screen capture settings
5. **hosts/mac/homebrew.nix**: Homebrew configuration
   - Taps, brews, casks, and MAS apps
   - Homebrew management settings
6. **hosts/mac/linux-builder.nix**: Linux builder configuration
   - VM configuration and SSH setup
   - Activation scripts for key management

**Expected Duration**: 4-5 hours

### Phase 3: Home Manager Configuration Modularization
**Objective**: Move user-level configuration to appropriate modules

**Tasks**:
1. **home/common/default.nix**: Base home configuration
   - Home Manager settings
   - Cross-platform package list
2. **home/common/cli.nix**: CLI tools configuration
   - Git configuration
   - SSH configuration with host blocks
   - Shell configuration (bash, starship)
   - CLI utilities (fzf, zoxide, bat, yazi)
3. **home/common/development.nix**: Development environments
   - Convert current dev shells to proper configurations
   - Python, Node.js, and temporary environments
   - Development tool configurations
4. **home/mac/default.nix**: macOS home base
   - macOS-specific home settings
   - Integration with system configuration
5. **home/mac/apps.nix**: macOS-specific applications
   - macOS-specific configurations
   - Application-specific settings

**Expected Duration**: 3-4 hours

### Phase 4: Integration and Testing
**Objective**: Ensure all configurations work together properly

**Tasks**:
1. Update flake.nix to properly reference new modular structure
2. Test configuration with `darwin-rebuild --flake . switch`
3. Verify all current functionality is preserved
4. Fix any import or dependency issues
5. Optimize module organization based on testing results

**Expected Duration**: 2-3 hours

## Technical Implementation Details

### Flake.nix Structure
The new flake.nix will be significantly simplified:

```nix
{
  description = "Modular Darwin configuration";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs = inputs@{ nixpkgs, home-manager, darwin, ... }: {
    darwinConfigurations = {
      nikhilmaddirala-mbp = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./hosts/common
          ./hosts/mac
          inputs.nix-homebrew.darwinModules.nix-homebrew
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.nikhilmaddirala = import ./home/mac;
          }
        ];
      };
    };
    
    # Development shells preserved
    devShells.aarch64-darwin = {
      # Moved to home/common/development.nix
    };
  };
}
```

### Module Import Strategy
Each module will use proper NixOS module structure:

```nix
# Example: hosts/mac/default.nix
{ config, pkgs, inputs, ... }: {
  imports = [
    ./system-defaults.nix
    ./homebrew.nix
    ./linux-builder.nix
  ];
  
  # Darwin-specific base configuration
  system.stateVersion = 4;
  nixpkgs.hostPlatform = "aarch64-darwin";
  # ... other Darwin-specific settings
}
```

### Cross-Platform Considerations
- **Common modules** contain only cross-platform configuration
- **Platform modules** handle system-specific requirements
- **Future Linux support** can be added without affecting existing configuration

## Benefits Analysis

### Immediate Benefits
1. **Improved Maintainability**: Smaller, focused files easier to understand and modify
2. **Better Organization**: Logical separation of concerns
3. **Reduced Complexity**: Each file has a single, clear purpose
4. **Easier Debugging**: Issues can be isolated to specific modules
5. **Better Testing**: Individual modules can be tested independently

### Long-term Benefits
1. **Scalability**: Easy to add new hosts or users
2. **Reusability**: Modules can be shared and reused
3. **Cross-platform Ready**: Structure supports future Linux configurations
4. **Collaboration Friendly**: Multiple people can work on different modules
5. **Documentation**: Each module can be self-documenting

### Migration Risk Mitigation
1. **Backup Strategy**: Git repository provides rollback capability
2. **Incremental Approach**: Each phase can be tested independently
3. **Functionality Preservation**: All current features will be maintained
4. **Testing Strategy**: Comprehensive testing after each phase

## File Mapping Reference

### Current flake.nix Content Distribution
| Current Section | Target Location | Lines |
|----------------|----------------|-------|
| Input definitions | flake.nix | 10 |
| System packages | hosts/mac/default.nix | 15 |
| Nix settings | hosts/common/default.nix | 20 |
| Linux builder | hosts/mac/linux-builder.nix | 40 |
| System defaults | hosts/mac/system-defaults.nix | 50 |
| Homebrew config | hosts/mac/homebrew.nix | 50 |
| User definition | hosts/common/users.nix | 15 |
| Home Manager packages | home/common/cli.nix | 30 |
| Shell configuration | home/common/cli.nix | 40 |
| SSH configuration | home/common/cli.nix | 30 |
| Development shells | home/common/development.nix | 40 |

## Success Criteria

### Functional Requirements
- [ ] System rebuilds successfully with `darwin-rebuild switch`
- [ ] All current packages and applications are available
- [ ] All system defaults and preferences are preserved
- [ ] Homebrew configuration works identically
- [ ] Development shells function as before
- [ ] SSH configuration is preserved
- [ ] Linux builder VM works correctly

### Non-Functional Requirements
- [ ] Configuration is organized into logical, focused modules
- [ ] Each module has a single, clear responsibility
- [ ] Module dependencies are explicit and minimal
- [ ] Documentation is clear and comprehensive
- [ ] Future modifications are easier than before

## Timeline and Effort Estimate

| Phase | Duration | Effort Level |
|-------|----------|-------------|
| Phase 1: Structure Creation | 2-3 hours | Medium |
| Phase 2: System Configuration | 4-5 hours | High |
| Phase 3: Home Manager Configuration | 3-4 hours | High |
| Phase 4: Integration and Testing | 2-3 hours | Medium |
| **Total** | **11-15 hours** | **High** |

## Rollback Strategy

If issues arise during migration:
1. **Git rollback**: Use `git reset --hard HEAD~1` to return to previous state
2. **Incremental rollback**: Each phase is committed separately for selective rollback
3. **Module-level rollback**: Individual modules can be reverted while keeping others
4. **Emergency fallback**: Keep current working configuration as backup

## Future Enhancements

Once the modular architecture is established:
1. **Linux Support**: Add server configurations for Linux hosts
2. **Custom Modules**: Create reusable modules for common patterns
3. **Overlay System**: Add package overlays for customizations
4. **Multi-User Support**: Extend to support multiple users
5. **Secrets Management**: Integrate with sops-nix or agenix for secrets

## Conclusion

This modular architecture migration will transform the current monolithic configuration into a maintainable, scalable, and future-ready system. The simplified platform-based organization makes the configuration easier to understand while preparing for future expansion to Linux servers and additional users.

The migration preserves all current functionality while providing a solid foundation for future development and collaboration.