# Modules

This directory organizes reusable configuration modules. Modules are split into `common/` (shared utilities), `home/` (home-manager configurations), and `hosts/` (system configurations for NixOS/Darwin).

## Module Structure

System modules in `hosts/` are organized as subdirectories with `default.nix` handling platform-conditional logic. Home-manager modules in `home/` follow a similar structure where applicable.

- **common/**: Shared utilities and secrets registry.
- **home/**: Home-manager modules (shell configs, tools, themes, etc.).
- **hosts/**: System modules for NixOS/Darwin hosts.
  - **base/**: Core system settings (packages, Nix daemon, GC).
  - **nix-settings/**: Nix configuration (experimental features, caches, trusted keys).
  - **sops/**: Secrets management with platform-specific group handling.
  - **users-shells/**: User and shell configuration, including Home Manager integration.
  - **nixos-server/**: NixOS server essentials.
  - **nixos-desktop/**: NixOS desktop environments and tools.
  - **darwin-desktop/**: Darwin desktop tools and settings.

## Platform Conditional Logic

Each `hosts/` module's `default.nix` uses `lib.optional` with `isLinux`/`isDarwin` to import platform-specific files conditionally. Cross-platform logic is in `common.nix`, platform-specific in `darwin.nix`/`linux.nix`.

## User Management (hosts/users-shells/)

Centralized user configuration with a single source of truth. Each user profile defines shell, SSH keys, and group memberships. Hosts activate users by setting `myUsers.<username>.enable = true`. The module handles platform-specific differences between NixOS (with groups and SSH keys) and Darwin (minimal configuration).


