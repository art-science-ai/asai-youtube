{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      pull.rebase = true;
      pull.ff = "only";
      push.autoSetupRemote = true;
      # credential.helper = "store";
    };
  };

  # programs.delta = {
  #   enable = true;
  #   options = {
  #     navigate = true;
  #     line-numbers = true;
  #     side-by-side = true;
  #   };
  # };

  programs.gh = {
    enable = true;
    # gitCredentialHelper = {
    #   enable = true;
    # };
    settings = {
      git_protocol = "ssh";
    };
  };

  programs.jujutsu = {
    enable = true;
    settings = {
      ui = {
        default-command = "log";
        paginate = "never";
      };
      git = {
        auto-local-branch = true;
      };
    };
  };
}
