{ lib, config, ... }:

{
  # Linux-specific: bootstrap handling for SSH host key
  config = lib.mkIf config.mySops.enable {
    sops.age.keyFile = lib.mkDefault (if builtins.pathExists "/etc/ssh/ssh_host_ed25519_key"
      then "/etc/ssh/ssh_host_ed25519_key"
      else "/dev/null");
  };
}