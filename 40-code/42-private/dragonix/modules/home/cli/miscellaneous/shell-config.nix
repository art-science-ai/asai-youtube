# Shell configurations (bash, zsh, fish, nushell)
# Includes starship prompt and shell aliases
{
  config,
  pkgs,
  lib,
  ...
}:
let
  # Import shared secrets registry (single source of truth for all secrets)
  secretsRegistry = import ../../../common/secrets-registry.nix { inherit lib; };
  inherit (secretsRegistry)
    secretDefinitions
    mkBashSecretLoader
    mkFishSecretLoader
    mkNushellSecretEnvVars
    ;

  # Transform alias for Nushell compatibility
  # Converts "VAR=value command" to "with-env { VAR: value } { command }"
  transformAliasForNushell =
    alias:
    let
      # Check if alias contains env var assignment pattern
      hasEnvVar = builtins.match "^[A-Za-z_][A-Za-z0-9_]*=[^ ]+ .*" alias != null;
    in
    if hasEnvVar then
      let
        # Split on first space to separate env assignments from command
        parts = lib.splitString " " alias;
        # First part is the env var assignment
        envPart = builtins.head parts;
        # Rest is the command
        cmdParts = builtins.tail parts;
        cmdStr = lib.concatStringsSep " " cmdParts;
        # Parse env var: split on "="
        envSplit = lib.splitString "=" envPart;
        envVar = builtins.head envSplit;
        envValue = lib.concatStringsSep "=" (builtins.tail envSplit);
      in
      "with-env { ${envVar}: ${envValue} } { ${cmdStr} }"
    else
      alias;

  # Common shell aliases/abbreviations
  commonShellAliases = {
    hello = "echo hello from nix home manager shell alias";

    # eza aliases
    ez = "eza --color=always -lh --git --no-filesize --icons=always --no-user --no-permissions";

    # npm packages
    xccr = "command npx -y @musistudio/claude-code-router@latest";
    xgemini = "command npx -y @google/gemini-cli@latest";
    xclaude = "command npx -y @anthropic-ai/claude-code@latest";
    xcodex = "command npx -y @openai/codex@latest";
    xoc = "command npx -y opencode-ai@latest";

    # uvx python
    xyta = "uvx --from youtube-transcript-api youtube_transcript_api";

  };

  # Transform aliases for Nushell compatibility
  nushellShellAliases = lib.mapAttrs (_name: transformAliasForNushell) commonShellAliases;
in
{
  # Set base environment variables with defaults that can be overridden per host
  home.sessionVariables = {
    EDITOR = lib.mkForce "nxd"; # nixvim-dragon (Nix-based configuration)
    TERMINAL = "wezterm";
    SOPS_AGE_KEY_FILE = "$HOME/.config/sops/age/keys.txt";
  };

  # Configure bash
  # Configure bash
  programs.bash = {
    enable = true;
    shellAliases = commonShellAliases;
    initExtra = ''
      # Load secrets from /run/secrets/ if available
      ${mkBashSecretLoader secretDefinitions}
    '';
  };

  # Configure zsh
  programs.zsh = {
    enable = true;
    shellAliases = commonShellAliases;
    syntaxHighlighting = {
      enable = true;
      # styles.default  = "fg=brightblack";  # fixes overly bright white
      # styles.argument = "fg=cyan";   # prevents unreadable white values
    };
    autosuggestion = {
      # highlight = "fg=cyan";
      enable = true;
    };
    oh-my-zsh.enable = true;
    oh-my-zsh.plugins = [ ];
    initContent = ''
      # Load secrets from /run/secrets/ if available
      ${mkBashSecretLoader secretDefinitions}
    '';
    plugins = [
      {
        name = "zsh-abbr";
        src = pkgs.zsh-abbr;
      }
    ];
  };

  programs.zsh.zsh-abbr.abbreviations = commonShellAliases;

  # Carapace - multi-shell completion engine for 1000+ commands
  programs.carapace.enable = true;

  # Configure fish
  # programs.fish = {
  #   enable = true;
  #   shellAbbrs = commonShellAliases;
  #   shellAliases = commonShellAliases;
  #   interactiveShellInit = ''
  #     set fish_greeting # Disable greeting
  #
  #     # override to make legible with catppuccin terminals
  #     # set fish_color_autosuggestion "white"
  #     # set fish_color_param "blue"
  #
  #     # Load secrets from /run/secrets/ if available
  #     ${mkFishSecretLoader secretDefinitions}
  #   '';
  #   plugins = [ ];
  # };

  # Configure nushell
  programs.nushell = {
    enable = true;
    shellAliases = nushellShellAliases;

    # Environment variables for Nushell (from centralized secrets registry)
    environmentVariables = mkNushellSecretEnvVars secretDefinitions;

    # Sensible config defaults
    settings = {
      show_banner = false;

      table = {
        mode = "rounded";
      };

      history = {
        file_format = "sqlite";
        isolation = false;
      };

      completions = {
        external = {
          enable = true;
          max_results = 100;
        };
      };
    };
  };

  # Enable Starship prompt
  programs.starship = {
    enable = true;
    settings = {
      username = {
        show_always = true;
      };
      hostname = {
        ssh_only = false;
      };
      shell = {
        disabled = false;
      };
      nix_shell = {
        heuristic = true;
      };
    };
  };
}
