{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  # Enable OpenCode
  programs.opencode.enable = true;
  programs.opencode.package = inputs.llm-agents.packages.${pkgs.system}.opencode;

  # Copy files to config directory
  home.file.".config/opencode/AGENTS.md".source = ../common/AGENTS.md;
  home.file.".config/opencode/ask-prompt.txt".source = ./ask-prompt.txt;
  home.file.".config/opencode/themes/opencode-catppuccin.json".source = ./opencode-catppuccin.json;
  home.file.".config/opencode/oh-my-opencode.json".source = ./oh-my-opencode.jsonc;

  # Configure OpenCode settings
  programs.opencode.settings = lib.mkMerge [
    {
      tui = {
        scroll_speed = 3;
        scroll_acceleration = {
          enabled = true;
        };
      };
      layout = "auto";
      share = "manual";
      instructions = ["AGENTS.md"];
      theme = "opencode-catppuccin";
      agent = {
        build = {
          permission = {
            bash = {
              "git commit*" = "ask";
              "just*" = "ask";
              "just check*" = "allow";
              "nix*" = "ask";
              "nh*" = "ask";
            };
          };
        };

        plan = {
          tools = {
            edit = false;
          };
          permission = {
            bash = {
              "just check*" = "allow";
              "git diff*" = "allow";
            };
          };
        };

        ask = {
          prompt = "{file:./ask-prompt.txt}";
          tools = {
            edit = false;
          };
          permission = {
            bash = {
              "just check*" = "allow";
            };
          };
        };
      };

      # Plugins
      plugin = [
        # "opencode-openai-codex-auth"
        # "opencode-skills"
        # "oh-my-opencode"
      ];

      # LSP Servers
      lsp = {
        # Nix LSP with full configuration
        nixd = {
          command = ["nixd"];
          extensions = [".nix"];
        };
      };

      provider = {
        openrouter = {
          npm = "@ai-sdk/openai-compatible";
          name = "openrouter";
          options = {
            baseURL = "https://openrouter.ai/api/v1";
          };
        };
      };
    }
    # {
    #   provider = (builtins.fromJSON (builtins.readFile ./openai-oauth.json)).provider;
    # }
  ];
}
