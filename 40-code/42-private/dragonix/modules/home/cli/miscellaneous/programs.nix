# CLI programs configurations - editors, git, shell tools, etc.
{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
  ];

  # Terminal programs with configurations
  programs = {
    atuin = {
      enable = true;
    };

    bat = {
      enable = true;
      config = {
        style = "numbers,changes,header";
        pager = "less -FR";
      };
    };

    eza = {
      enable = true;
      extraOptions = [
        "--color=always"
        "--git"
        "--icons=always"
        "--no-filesize"
        "--no-user"
        "--no-permissions"
      ];
      git = true;
      icons = "always";
    };

    fzf = {
      enable = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    ripgrep = {
      enable = true;
      arguments = [
        "--hidden" # Show hidden files (dotfiles) in searches
        "--glob=!.git/*" # Exclude .git directory
      ];
    };

    # Development editor configurations moved to modules/home/ide/

    neovim = {
      enable = true;
      defaultEditor = false;
      withPython3 = true;
      withNodeJs = true;
    };

    git = {
      enable = true;
      settings = {
        init.defaultBranch = "main";
        pull.rebase = true;
        pull.ff = "only";
        push.autoSetupRemote = true;
        credential.helper = "store";
      };
    };

    delta = {
      enable = false;
      options = {
        navigate = true;
        line-numbers = true;
        side-by-side = true;
      };
    };

    gh = {
      enable = true;
      gitCredentialHelper = {
        enable = true;
      };
      settings = {
        git_protocol = "ssh";
      };
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks."*" = {
        forwardAgent = false;
        addKeysToAgent = "no";
        compression = false;
        serverAliveInterval = 0;
        serverAliveCountMax = 3;
        hashKnownHosts = false;
        userKnownHostsFile = "~/.ssh/known_hosts";
        controlMaster = "no";
        controlPath = "~/.ssh/master-%r@%n:%p";
        controlPersist = "no";
      };
    };
  };
}
