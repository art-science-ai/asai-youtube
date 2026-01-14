# Host Configuration

This document outlines the architecture, installation, and management of the Nix-based system configurations for all machines in this repository.

## Host Profiles

This section provides an overview of each machine managed by this repository.

| Host         | Architecture   | OS      | Location   | Type            | Description                               | Status   |
| :----------- | :------------- | :------ | :--------- | :-------------- | :---------------------------------------- | :------- |
| **Meleys**   | `aarch64-darwin` | macOS   | On-premise | Desktop         | Daily driver for development and work.    | Archived |
| **Moondancer** | `aarch64-darwin` | macOS   | On-premise | Desktop         | Personal macOS machine.                   | Active   |
| **Seasmoke** | `x86_64-linux` | NixOS   | Cloud      | Server (VPS)    | Hosts personal open-source applications.  | Active   |
| **Vermax**   | `x86_64-linux` | NixOS   | On-premise | Desktop         | NixOS desktop with containers.            | Active   |
| **Sheepstealer** | `x86_64-linux` | Linux   | Cloud      | Server (Seedbox)| Dedicated server for torrenting and media. | Active   |

### Meleys
- **Type**: macOS (MacBook Pro)
- **Role**: My daily driver for development and work. It is my most powerful machine, used for heavy workloads like local LLMs and complex builds. It also serves as the control center for managing all other systems.
- **Setup Notes**: Uses the vanilla Nix installer. As a corporate Mac, it requires some workarounds for Chef compatibility.

### Moondancer
- **Type**: macOS
- **Role**: A multi-user macOS machine with shared Homebrew packages accessible to all users.
- **Users**: nikhilmaddirala (primary, has home-manager config) and rukmasen (manual environment)
- **Setup Notes**: Uses the Determinate Nix Installer. Homebrew is managed at the system level with `nikhilmaddirala` as the primary user. Uses `nix.enable = false` to prevent conflicts with Determinate Nix's daemon management.

### Seasmoke
- **Type**: NixOS (Hetzner VPS)
- **Role**: A server for hosting various open-source applications for personal use, such as `n8n`, AI chat interfaces, `Obsidian LiveSync`, `Home Assistant`, and more.
- **Services**: It runs a core set of infrastructure services including a reverse proxy (Traefik), databases, backup solutions, and monitoring.
- **Future Goals**: To become the hub for a personal AI agent, with data ingestion pipelines and a private execution environment.

### Vermax
- **Type**: NixOS (Desktop with Containers)
- **Role**: On-premise NixOS machine for development, testing containers, and running services locally.
- **Users**: nikhilmaddirala, rukmasen, guest
- **Setup Notes**: Bootstrapped via nixos-anywhere. Includes impermanence and full disk encryption.

### Sheepstealer
- **Type**: Seedbox (Managed manually, future NixOS target)
- **Role**: A server for sketchy activities like torrenting.
- **Services**: Runs `qbittorrent`, `Jellyfin`, `Audiobookshelf`, and the `*arr` stack.
- **Future Goals**: To be declaratively managed by this configuration. Non-TOS-violating services will be migrated to Seasmoke, leaving Sheepstealer dedicated to torrenting and file storage, remotely managed by Seasmoke.



### nixos-anywhere (Bootstrap Templates)
- **Type**: NixOS provisioning templates
- **Location**: `modules/nixos-anywhere/`
- **Role**: Standalone bootstrap configurations for provisioning fresh NixOS machines via `nixos-anywhere` from a standard Linux distribution.
- **Structure**: Contains host-specific bootstrap configs (e.g., `vermax/`) and a reusable `template/` for new hosts.
- **Documentation**: See `modules/nixos-anywhere/README.md` for complete bootstrap workflow and instructions.

## Installation and Management

This section covers the lifecycle of a host, from initial setup to daily maintenance.

### Bootstrapping a New Host

There are two primary workflows for bringing a new machine under Nix management, based on the host's operating system.

---

#### Workflow 1: Non-NixOS Hosts (e.g., macOS, Arch Linux)

This workflow applies to machines where the operating system is already installed. The process involves adding Nix on top of the existing OS.

**Step 0: Prerequisites**

Before installing Nix, a few manual steps are required to prepare the machine for declarative management.

1.  **Install 1Password:**
    -   Download and install the 1Password desktop application and browser extension.
    -   Log in to your 1Password account to access your secrets, including your GitHub credentials, which you'll need to log in to the GitHub website.

2.  **Generate and Add SSH Key to GitHub:**
    -   First, generate a new ED25519 SSH key on the new machine. Run the following command and follow the prompts. It's recommended to use a passphrase for the key.
        ```bash
        ssh-keygen -t ed25519 -C "your_email@example.com"
        ```
    -   Next, copy the public key to your clipboard. On macOS, you can use `pbcopy`:
        ```bash
        pbcopy < ~/.ssh/id_ed25519.pub
        ```
        *On other systems, you may need to `cat ~/.ssh/id_ed25519.pub` and copy the output manually.*
    -   Open your web browser and log in to GitHub (using your credentials from 1Password). Navigate to `Settings > SSH and GPG keys` and click "New SSH key". Paste your key into the "Key" field and give it a title.

3.  **Clone the Repository:**
    -   With the SSH key added to GitHub, you can now clone the repository. Navigate to the directory where you store your projects and run:
        ```bash
        git clone git@github.com:nikhilmaddirala/nix-config.git
        cd nix-config
        ```
    -   This provides the necessary flake files to proceed with the Nix installation. Note that this manually created SSH key might be replaced by the declarative Nix configuration once it's applied.

**Step 1: Install Xcode Command Line Tools**
Before installing Nix, ensure you have the latest Xcode Command Line Tools:
```bash
xcode-select --install
```

If you already have the Command Line Tools installed but they're outdated, update them:
```bash
softwareupdate -i "Command Line Tools for Xcode-26"
```
*(Replace "26" with the version shown in `softwareupdate -l` if different.)*

**Step 2: Install Nix**
The recommended method is to use the Determinate Nix Installer: https://github.com/DeterminateSystems/nix-installer
```bash
# Determinate nix
curl -fsSL https://install.determinate.systems/nix | sh -s -- install --determinate

# Vanilla nix
curl -fsSL https://install.determinate.systems/nix | sh -s -- install
```
*Note: For host-specific installation choices (e.g., vanilla installer vs. Determinate installer) or workarounds, see the "Setup Notes" in the respective [Host Profiles](#host-profiles).*


**Step 3: Apply the Configuration**
Once Nix is installed, apply the appropriate configuration from this flake. This command is for macOS; similar steps apply to other Linux distributions.
```bash
# For macOS, using nix-darwin - first time (nh not yet in PATH)
sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake .#<hostname>

# macOS - after first time (nh is now available)
just <hostname>-all

# Or manually:
sudo darwin-rebuild switch --flake .#<hostname>

```

**For Moondancer specifically (first time setup):**
Moondancer uses the Determinate Nix Installer and requires special handling due to its daemon management. After applying the system configuration, you must also activate the home-manager configuration:
```bash
# First, apply the system configuration
sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake .#moondancer

# Then, activate home-manager for your user
nix run home-manager/master -- switch --flake .#nikhilmaddirala@moondancer

# After first time, use the just commands:
just moondancer-all
```

---

#### Workflow 2: NixOS Hosts

This workflow installs NixOS as the primary operating system on a bare-metal machine or VPS, replacing any existing OS.

**Step 1: Provision a Server**
Start with a server running a basic Linux distribution (e.g., Ubuntu) that can be accessed via SSH.

**Step 2: Install NixOS using `nixos-anywhere`**
Bootstrap templates are located in `modules/nixos-anywhere/`. For detailed instructions on provisioning a new NixOS host from bare metal, refer to `modules/nixos-anywhere/README.md`.

For example, to bootstrap a new host based on the template:
```bash
# Copy template and customize for your hardware
cp -r modules/nixos-anywhere/template modules/nixos-anywhere/newhostname

# Edit configuration for SSH keys, disk layout, etc.
# Then run the installer from the template directory
cd modules/nixos-anywhere/newhostname
nix run github:nix-community/nixos-anywhere -- \
  --generate-hardware-config nixos-generate-config ./hardware-configuration.nix \
  --flake .#newhostname \
  --target-host user@target-ip
```

**Step 3: Import Hardware Configuration**
After the first successful installation, copy the generated `hardware-configuration.nix` and `disk-config.nix` from the new host back into its configuration directory in this repository. This ensures that future rebuilds are aware of the specific hardware.

### Daily Operations
To apply changes to an already bootstrapped machine, use the appropriate rebuild command.

**For macOS:**
```bash
# Rebuild from local repository
sudo darwin-rebuild switch --flake .#<hostname>

# Rebuild from remote repository
sudo darwin-rebuild switch --flake git+ssh://git@github.com/nikhilmaddirala/nix-config#<hostname>
```

**For NixOS:**
Deploying to a NixOS server is best done with `deploy-rs`.
```bash
# Deploy to a server defined in the flake
nix run github:serokell/deploy-rs .#<hostname>
```

### Adding a New Host
1.  Create a directory `hosts/<hostname>/` with a `default.nix`.
2.  In `default.nix`, import only the modules needed from `modules/hosts/`:
    - macOS: `../modules/hosts/base`, `../modules/hosts/darwin-desktop`, `../modules/hosts/users-shells`
    - NixOS Server: `../modules/hosts/base`, `../modules/hosts/nixos-server`, `../modules/hosts/sops`, `../modules/hosts/users-shells`
    - NixOS Desktop: `../modules/hosts/base`, `../modules/hosts/nixos-desktop`, `../modules/hosts/sops`, `../modules/hosts/users-shells`
3.  Add any host-specific configuration (hardware, services, overrides).
4.  Update `flake.nix`:
    -   Add to `darwinConfigurations` or `nixosConfigurations`
    -   Add corresponding `homeConfigurations` for each user
    -   Add to `checks` section
5.  Create user-host files in `home/` (e.g., `home/nikhilmaddirala-<hostname>.nix`)
6.  Run `nix flake check` to verify before deploying

Example for a new macOS host:
```nix
# hosts/mynewmac/default.nix
{
  imports = [
    ../modules/hosts/base
    ../modules/hosts/darwin-desktop
    ../modules/hosts/users-shells
  ];

  # Host-specific overrides only
  networking.computerName = "mynewmac";
  # ... other customizations
}
```

### Quick Reference: Where to Edit
| Task | Location |
|------|----------|
| Core shared settings (Nix, packages) | `modules/hosts/base/` |
| Nix configuration (flakes, caches) | `modules/hosts/nix-settings/` |
| SOPS secrets management | `modules/hosts/sops/` |
| User/shell configuration | `modules/hosts/users-shells/` |
| NixOS server essentials | `modules/hosts/nixos-server/` |
| NixOS desktop environments | `modules/hosts/nixos-desktop/` |
| macOS desktop tools/settings | `modules/hosts/darwin-desktop/` |
| SSH keys for seasmoke | `hosts/seasmoke/default.nix` |
| Host-specific hardware/services | `hosts/<hostname>/default.nix` |

### Uninstalling Nix
If you need to remove Nix from a system:

**Using the Determinate Nix Installer:**
```bash
sudo /nix/nix-installer uninstall
```

**Using the official Nix installer:**
Follow the instructions at [nix.dev](https://nix.dev/manual/nix/2.18/installation/uninstall).

## System Architecture

The configuration is designed to be modular, reusable, and easy to maintain across different operating systems and machine roles.

### Core Concepts
- **System Configuration**: Managed through `darwinConfigurations` (for macOS) and `nixosConfigurations` (for Linux) in `flake.nix`. These handle system-wide settings, services, and packages.
- **User Configuration**: Managed through standalone `homeConfigurations` for independent user environment management. This includes user-specific applications, CLI tools, and dotfiles.
- **Package Management**: A multi-layered approach is utilized, incorporating Nix packages, Homebrew (on macOS), and Mac App Store (on macOS) for comprehensive software management.

### Directory Structure
The `hosts/` directory contains self-contained host configurations. Each host is a directory with a `default.nix` that imports only the modules it needs from `modules/hosts/`.

```
hosts/
├── meleys/                         # macOS single-user
│   └── default.nix                 # Imports: base, darwin-desktop, users-shells
├── moondancer/                     # macOS multi-user
│   └── default.nix                 # Imports: base, darwin-desktop, users-shells
├── seasmoke/                       # NixOS server with services
│   ├── default.nix                 # Imports: base, nix-settings, nixos-server, sops, users-shells
│   ├── services/                   # Server service definitions
│   ├── containers/                 # Container configurations
│   ├── disk-config.nix             # Disk partitioning layout
│   ├── hardware-configuration.nix  # Generated hardware config
│   └── ports.nix                   # Port allocation registry
└── vermax/                         # NixOS desktop with containers
    ├── default.nix                 # Imports: base, nix-settings, nixos-desktop, sops, users-shells
    ├── containers/                 # Container definitions
    └── hardware-configuration.nix  # Generated hardware config
```

All shared modules are consolidated in `modules/hosts/` as subdirectories with `default.nix` handling platform logic:

```
modules/hosts/
├── base/                           # Core system settings (packages, Nix daemon, GC)
├── nix-settings/                   # Nix configuration (experimental features, caches)
├── sops/                           # Secrets management with platform-specific group handling
├── users-shells/                   # User and shell configuration, Home Manager integration
├── nixos-server/                   # NixOS server essentials
├── nixos-desktop/                  # NixOS desktop environments and tools
└── darwin-desktop/                 # Darwin desktop tools and settings
```

**File naming conventions:**

- `default.nix` in `hosts/<hostname>/`: Self-contained host configuration that imports modules
- `<module>/default.nix`: Handles platform-conditional imports for that module
- Platform-specific files (e.g., `darwin.nix`, `linux.nix`) contain logic isolated by `default.nix`

### Composition Example: How Hosts Are Built

Each host composes only the modules it needs:

```nix
# hosts/seasmoke/default.nix
{
  imports = [
    ../modules/hosts/base           # Core system settings
    ../modules/hosts/nix-settings   # Nix configuration
    ../modules/hosts/nixos-server   # Server essentials
    ../modules/hosts/sops           # Secrets management
    ../modules/hosts/users-shells   # User/shell config
    ./hardware-configuration.nix                  # Generated hardware config
    ./services                                    # Local service definitions
    ./containers                                  # Container configurations
  ];

  # Host-specific customizations only
  networking.hostName = "seasmoke";
  # ... other settings
}
```

Benefits of this approach:
- **No duplication**: Each module exists once in `modules/`
- **Clear composition**: See exactly what each host imports by reading its `default.nix`
- **Easy to extend**: Add modules without touching existing configs
- **Easy to understand**: No hidden imports from nested directories

### User Management
Users are centrally managed in `modules/hosts/users-shells/`, with platform-specific handling. Hosts activate users by setting `myUsers.<username>.enable = true`. See `modules/hosts/users-shells/users-shells.nix` for profiles and `modules/README.md` for details.

## Appendix Multi-User Setup on macOS - Moondancer

Moondancer is a multi-user macOS machine, whereas Meleys is single-user. This requires a different configuration approach that separates system-wide settings from user-specific preferences.

### Key Principles

- System configuration (nix-darwin) manages settings for all users
- User configuration (home-manager) manages per-user environments  
- Homebrew is configured at the system level for shared package access
- `system.primaryUser` must be set when using Homebrew (nix-darwin requirement)
- The primary user is responsible for managing system-wide Homebrew packages

### System Configuration (nix-darwin)

Manages settings for all users on the system.

**Include:**
- All user accounts in `users.users`
- System-wide packages in `environment.systemPackages`
- Homebrew configuration (accessible to all users via `/opt/homebrew`)
- `system.primaryUser` set to the Homebrew manager (required by nix-darwin)
- System-level services and security settings

**Exclude:**
- User-specific macOS preferences (Dock, Finder settings belong in home-manager)
- User-specific PATH configurations (except system-wide /opt/homebrew)

Example: `hosts/moondancer/default.nix`
```nix
{ pkgs, inputs, lib, ... }: {
  imports = [
    ../common-macos  # Provides base + homebrew + macos-settings
  ];

  # Additional user accounts beyond what's in common-macos/users.nix
  users.users.rukmasen = {
    home = "/Users/rukmasen";
    shell = pkgs.zsh;
  };

  # Disable nix-darwin's Nix daemon management since Determinate Nix manages it
  nix.enable = false;

  # Disable automatic garbage collection (Determinate Nix can manage this)
  nix.gc.automatic = lib.mkForce false;
}
```

### User Configuration (home-manager)

Only users needing declarative environment management require a home-manager configuration. On Moondancer, only nikhilmaddirala has one.

Home-manager configurations handle:
- User-specific packages and dotfiles
- Personal shell configurations
- macOS user preferences

Users without home-manager (like rukmasen) manage their environment manually. They benefit from system-level Homebrew packages and shells enabled at the system level, but their personal environment is not declaratively managed.

### Activation

```bash
# System configuration (includes Homebrew for all users)
sudo darwin-rebuild switch --flake .#moondancer

# User environment (nikhilmaddirala only)
home-manager switch --flake .#nikhilmaddirala@moondancer
```

Other users manage their environment manually via standard macOS tools.

### Implementation Steps

1. ✅ Core system-wide settings (shells, security, GC schedule) are in `hosts/common-macos/default.nix`
2. ✅ Shared Homebrew packages in `hosts/common-macos/homebrew.nix`
3. ✅ macOS-specific user overrides in `hosts/common-macos/users.nix` (sets primary user)
4. ✅ Configure `hosts/moondancer/default.nix` to define additional user accounts (rukmasen)
5. ✅ Create home-manager configuration for nikhilmaddirala at `flake.nix` (nikhilmaddirala@moondancer)
6. ✅ Home-manager modules imported from `home/hosts/common-macos`, `home/users/nikhilmaddirala`, and `home/hosts/moondancer`
7. ✅ Validate with `nix flake check`

All implementation steps are complete. The configuration is ready for deployment.
