{ lib, config, ... }:
let
  # Import shared secrets registry (single source of truth for all secrets)
  secretsRegistry = import ../../common/secrets-registry.nix { inherit lib; };
  inherit (secretsRegistry) secretDefinitions mkSopsSecrets;

  # Platform-specific settings for SOPS
  sopsSettings = {
    defaultSopsFile = ../../../vars/secrets.yaml;
    defaultSopsFormat = "yaml";
    validateSopsFiles = false;
    gnupg.sshKeyPaths = [ ];
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  };
in
{
  options.mySops = {
    enable = lib.mkEnableOption "SOPS secrets management" // {
      default = true;
      description = "Enable SOPS secrets management. Set to false during initial installation to prevent bootstrapping issues.";
    };
  };

  options.secretGroup = lib.mkOption {
    type = lib.types.str;
    description = "Platform-specific group for secret ownership";
  };

  # SOPS configuration - only enabled when mySops.enable = true
  config = lib.mkIf config.mySops.enable {
    # Common SOPS settings for all platforms
    sops.defaultSopsFile = sopsSettings.defaultSopsFile;
    sops.defaultSopsFormat = sopsSettings.defaultSopsFormat;
    sops.validateSopsFiles = sopsSettings.validateSopsFiles;
    sops.gnupg.sshKeyPaths = sopsSettings.gnupg.sshKeyPaths;
    sops.age.sshKeyPaths = sopsSettings.age.sshKeyPaths;

    # Common secrets declarations for all platforms (from centralized registry)
    sops.secrets = mkSopsSecrets secretDefinitions config.secretGroup;
  };
}