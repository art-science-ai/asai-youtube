# Personal user configuration for nikhilmaddirala
# Includes git settings, SSH configuration, 1Password integration, and editor preferences
{ config, pkgs, lib, ... }:

let
  isLinux = !pkgs.stdenv.isDarwin;
  isDarwin = pkgs.stdenv.isDarwin;
in
{
  # Git configuration
  programs.git.settings = {
    user = {
      name = "nikhilmaddirala";
      email = "nikhil.maddirala@gmail.com";
      # Set this to your actual SSH signing key from 1Password
      # Get it from: 1Password → SSH Keys → [Your Key] → Public Key
      # signingKey = "ssh-ed25519 AAAA...";
    };
    # core = {
    #   sshCommand = "/run/current-system/sw/bin/ssh";
    # };

    # Git commit signing via 1Password SSH keys
    # Uncomment after setting user.signingKey above
    # gpg.format = "ssh";
    # "gpg \"ssh\"".program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
    # commit.gpgsign = true;
  };

  # Jujutsu user identity (centralized)
  programs.jujutsu.settings = {
    user = config.userIdentity;
  };

  # SSH configuration with 1Password agent integration
  programs.ssh = {
    # 1Password SSH agent configuration
    # Smart forwarding: uses forwarded agent in SSH sessions, falls back to 1Password locally
    extraConfig = lib.mkMerge [
      (lib.mkIf isDarwin ''
        Host *

        # Use forwarded agent if in SSH session and agent exists
        Match exec "test -n \"$SSH_CONNECTION\" -a -S \"$SSH_AUTH_SOCK\""
          IdentityAgent $SSH_AUTH_SOCK

        # Otherwise (local physical access), use 1Password
        Match all
          IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
      '')
      (lib.mkIf isLinux ''
        Host *

        # Use forwarded agent if in SSH session and agent exists (e.g., moondancer -> vermax)
        Match exec "test -n \"$SSH_CONNECTION\" -a -S \"$SSH_AUTH_SOCK\""
          IdentityAgent $SSH_AUTH_SOCK

        # Otherwise (local physical access on vermax), use 1Password
        Match all
          IdentityAgent ~/.1password/agent.sock
      '')
    ];

    # SSH host configurations
    matchBlocks."sheepstealer" = {
      hostname = "15.lw.itsby.design";
      user = "box_ring_fence";
      forwardAgent = true;
    };
    matchBlocks."seasmoke" = {
      hostname = "91.99.176.80";
      user = "nikhilmaddirala";
      forwardAgent = true;
      extraOptions = {
        StrictHostKeyChecking = "no";
        UserKnownHostsFile = "/dev/null";
      };
    };
    matchBlocks."vermax" = {
      hostname = "192.168.1.19";
      user = "nikhilmaddirala";
      forwardAgent = true;
    };
  };

  }
