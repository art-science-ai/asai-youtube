# Unified user and shell configuration for both NixOS and Darwin
# Provides declarative user management and system shell configuration with platform-specific adaptations
{ config, pkgs, lib, inputs, ... }:
let
  inherit (pkgs.stdenv) isLinux isDarwin;

  # Centralized SSH public keys
  sshKeys = {
    nikhil-1p = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBrpbMwLVb28otKcvFmUguFYavpYmfW4fbXpDBraZeXK";
  };

  # Platform-agnostic user profile definitions.
  # Each profile contains shell, SSH keys, and NixOS group memberships.
  # Hosts activate users by setting myUsers.<username>.enable = true.
  userProfiles = {
    nikhilmaddirala = {
      shell = pkgs.zsh;
      sshKeys = [ sshKeys.nikhil-1p ];
      isAdmin = true;
      extraGroups = [ "wheel" "docker" "networkmanager" "input" "uinput" ];
      password = "changeme";
      homeManager = "standalone";  # Use standalone Home Manager
    };

    rukmasen = {
      shell = pkgs.bash;
      sshKeys = [ ];
      isAdmin = false;
      extraGroups = [ ];
      password = "changeme";
      packages = with pkgs; [ flatpak gnome-software ];
      homeManager = "nixos-module";  # Use NixOS Home Manager module
    };

    aegon = {
      shell = pkgs.bash;
      sshKeys = [ sshKeys.nikhil-1p ];
      isAdmin = true;
      extraGroups = [ "wheel" ];
      password = null;
      homeManager = "nixos-module";  # Use NixOS Home Manager module
    };

    tyrion = {
      shell = pkgs.bash;
      sshKeys = [ sshKeys.nikhil-1p ];
      isAdmin = false;
      extraGroups = [ ];
      password = null;
      homeManager = "nixos-module";  # Use NixOS Home Manager module
    };

    guest = {
      shell = pkgs.bash;
      sshKeys = [ sshKeys.nikhil-1p ];
      isAdmin = false;
      extraGroups = [ ];
      password = "guest";
      packages = with pkgs; [ flatpak gnome-software ];
      homeManager = "nixos-module";  # Use NixOS Home Manager module
    };

  };

  # Convert profile to NixOS user config. Includes groups, SSH keys, password, and packages.
  mkNixOSUser = username: profile: {
    isNormalUser = true;
    description = "${username}";
    home = "/home/${username}";
    extraGroups = profile.extraGroups or [];
    shell = profile.shell;
    openssh.authorizedKeys.keys = profile.sshKeys or [];
    # Set password if provided, otherwise no password (SSH keys only)
    initialPassword = lib.attrByPath [ "password" ] null profile;
    # Include user-specific packages if defined
    packages = profile.packages or [];
  };

  # Convert profile to Darwin user config. Darwin has minimal user config options.
  mkDarwinUser = username: profile: {
    home = "/Users/${username}";
    shell = profile.shell;
  };
in
{
  # Auto-generate a myUsers.<username>.enable option for each profile.
  # Hosts activate users by setting these booleans.
  options.myUsers = lib.genAttrs (lib.attrNames userProfiles) (username:
    lib.mkOption {
      type = lib.types.submodule {
        options = {
          enable = lib.mkEnableOption "${username} user" // {
            default = if username == "nikhilmaddirala" then true else false;
          };
        };
      };
      default = {};
    }
  );

  config = lib.mkMerge [
    # System shell configuration (cross-platform)
    {
      # Add all managed shells to /etc/shells (cross-platform)
      environment.shells = with pkgs; [ bash fish zsh nushell ];
    }

    # System shell programs for NixOS
    (lib.mkIf isLinux {
      programs.bash.enable = true;
      programs.zsh.enable = true;
    })

    # System shell programs for Darwin
    (lib.mkIf isDarwin {
      programs.bash.enable = true;
      programs.zsh.enable = true;
    })

    # Apply enabled users to NixOS systems.
    (lib.mkIf isLinux {
      users.users = lib.mapAttrs' (username: profile:
        lib.nameValuePair username (mkNixOSUser username profile)
      ) (lib.filterAttrs (username: _:
        config.myUsers.${username}.enable
      ) userProfiles);

          })

    # Apply enabled users to Darwin systems.
    (lib.mkIf isDarwin {
      users.users = lib.mapAttrs (username: profile:
        mkDarwinUser username profile
      ) (lib.filterAttrs (username: _:
        config.myUsers.${username}.enable
      ) userProfiles);
    })
  ];
}
