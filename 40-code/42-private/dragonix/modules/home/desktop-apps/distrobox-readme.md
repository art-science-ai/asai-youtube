## Distrobox

### Goals

- Access to latest packages not available in nixpkgs
- Install bleeding edge packages from Arch Linux AUR while keeping most packages in nixpkgs
- Declarative configuration via Home Manager with automatic package management
- Transparent integration of Arch packages into NixOS host system

### Implementation

#### Architecture

We use Home Manager's built-in `programs.distrobox` module to declaratively manage containers. The implementation consists of:

1. **Arch Linux container** running via Podman (rootless)
2. **Yay AUR helper** for package management inside the container
3. **Init hooks** that automatically:
   - Configure SSL certificates for NixOS host compatibility
   - Install yay if missing
   - Install declared AUR packages
4. **Binary exports** that expose container binaries to the host PATH
5. **Systemd service** that auto-rebuilds containers on config changes

#### Configuration Structure

The distrobox configuration is defined in `distrobox-config.nix` with:

- **Container isolation**: Separate home directory at `~/.local/share/distrobox-homes/archlinux` to avoid read-only config issues
- **Package declaration**: List of AUR packages in `aurPackages` attribute
- **Binary exports**: Map package binaries to host-accessible commands
- **SSL compatibility**: NixOS CA bundle mounted into container for git/curl operations

#### Declaring Packages

To add a new AUR package, modify the `aurPackages` list in `distrobox-config.nix`:

```nix
aurPackages = [
  {
    package = "package-name-from-aur";
    bin = "command-name-to-expose-on-host";
  }
];
```

Example:
```nix
{
  package = "claude-code";
  bin = "claude";
}
```

This will:
1. Install `claude-code` from AUR in the container
2. Expose the binary as `claude` on the host system
3. Automatically update when the Home Manager config changes

### Current Status

**Status**: Configuration implemented but **DISABLED** due to activation issues.

To enable: Uncomment `./distrobox-config.nix` in `modules/home/desktop-apps/default.nix`

### Known Issues and Next Steps

#### Issue 1: Init Hooks Format (RESOLVED)
**Problem**: Multi-line heredocs with Nix string interpolation were being corrupted when converted to INI format.

**Solution Implemented**: Converted all init hooks to single-line shell commands:
- SSL certificate setup: Changed from heredoc to simple `echo | sudo tee` commands
- Removed complex variable interpolation in favor of hardcoded paths
- Hardcoded AUR package names in init_hooks since they're already declared in `aurPackages`

#### Issue 2: Podman Service Readiness (PARTIALLY RESOLVED)
**Problem**: Distrobox tried to run before podman socket was ready, causing "Missing dependency" errors during activation.

**Solution Implemented**: Added service waiting logic with 10-second timeout:
```bash
# Start and wait for podman socket to be ready
systemctl --user start podman.socket

# Wait for podman to be available (max 10 seconds)
timeout=10
while ! podman info >/dev/null 2>&1; do
  if [ $timeout -le 0 ]; then
    echo "Error: podman did not become ready in time"
    exit 1
  fi
  sleep 1
  timeout=$((timeout - 1))
done
```

**Remaining Problem**: Activation is failing with exit code 1, likely because:
- Podman socket may not be starting properly on first activation
- OR Podman takes longer than 10 seconds to initialize on first run
- OR The `podman info` command fails due to missing configuration

#### Issue 3: Container Manager Options Format (RESOLVED)
**Problem**: The Home Manager distrobox module converts lists to duplicate INI keys, breaking options that need to be on a single line.

**Solution Implemented**:
- `additional_flags`: Changed from list `["--home" containerHome]` to string `"--home ${containerHome}"`
- `additional_packages`: Changed from list to space-separated string `"git base-devel ca-certificates openssl"`
- `exported_bins`: Changed from list to space-separated string using `lib.concatStringsSep " " exportedBins`

### Next Steps to Fix Activation

1. **Increase timeout**: Change from 10 seconds to 30-60 seconds to account for slow initial podman startup
2. **Add better logging**: Include error output from `podman info` to diagnose why it's failing
3. **Consider alternative activation**: Use Home Manager's `programs.distrobox.enableSystemdUnit` instead of manual activation script
4. **Test podman manually**: Verify podman works outside of activation first with:
   ```bash
   systemctl --user start podman.socket
   podman info
   ```

### System Requirements

- **NixOS host**: Podman must be available (rootless mode)
- **Home Manager**: Version with distrobox module support (24.05+)
- **Container manager**: Podman (preferred) or Docker

### Activation Flow (When Working)

When Home Manager applies the configuration:

1. Podman socket is started (user session)
2. Wait for podman to be ready (with timeout)
3. Distrobox reads `~/.config/distrobox/containers.ini`
4. Container is created/replaced with current configuration
5. Init hooks run inside container (yay setup, package installation)
6. Binaries are exported to host system
7. Desktop entries are created for GUI applications

### Maintenance

- **Add packages**: Add to `aurPackages` list and run `home-manager switch`
- **Remove packages**: Remove from `aurPackages` list and rebuild
- **Rebuild container**: Home Manager activation handles this automatically
- **Manual container access**: `distrobox enter archlinux`

### Build Time Expectations

- **First setup**: 10-20 minutes for building yay and AUR packages from scratch
- **Subsequent updates**: 2-5 minutes depending on package updates
- **Container rebuild**: ~30 seconds if no package changes
