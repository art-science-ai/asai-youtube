{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.helix = {
    enable = true;
    package = pkgs.evil-helix;
    defaultEditor = true;

    settings = {
      editor = {
        bufferline = "multiple";
        cursorline = true;
        line-number = "relative";
        rulers = [ 120 ];
        true-color = true;
        color-modes = true;
        auto-format = false;

        auto-save = {
          after-delay.enable = true;
        };

        file-picker = {
          hidden = false;
        };

        indent-guides = {
          render = true;
        };

        soft-wrap = {
          enable = true;
          wrap-at-text-width = false;
        };

        lsp = {
          auto-signature-help = false;
          display-messages = true;
        };

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        statusline = {
          left = [ "mode" "spinner" "version-control" ];
          center = [ "file-name" ];
          right = [
            "diagnostics"
            "selections"
            "position"
            "file-encoding"
            "file-line-ending"
            "file-type"
            "file-modification-indicator"
          ];
          separator = "│";
        };
      };

      keys.normal.space = {
        q = ":buffer-close";
      };
    };

    languages = {
      language-server = {
        nixd = {
          command = "nixd";
        };
        taplo = {
          command = "taplo";
          args = [ "lsp" "stdio" ];
        };
        yaml-language-server = {
          command = "yaml-language-server";
          args = [ "--stdio" ];
        };
        marksman = {
          command = "marksman";
          args = [ "server" ];
        };
        typescript-language-server = {
          command = "typescript-language-server";
          args = [ "--stdio" ];
        };
        kdl-lsp = {
          command = "kdl-lsp";
        };
        vscode-json-language-server = {
          command = "vscode-json-language-server";
          args = [ "--stdio" ];
        };
      };

      language = [
        {
          name = "nix";
          auto-format = true;
          language-servers = [ "nixd" ];
          formatter = {
            command = "nixfmt";
          };
        }
        {
          name = "toml";
          auto-format = true;
          language-servers = [ "taplo" ];
          formatter = {
            command = "taplo";
            args = [ "format" "-" ];
          };
        }
        {
          name = "yaml";
          language-servers = [ "yaml-language-server" ];
          auto-format = true;
          formatter = {
            command = "prettier";
            args = [ "--stdin-filepath" "%{buffer_name}" ];
          };
        }
        {
          name = "markdown";
          language-servers = [ "marksman" ];
          auto-format = true;
          formatter = {
            command = "prettier";
            args = [ "--stdin-filepath" "%{buffer_name}" ];
          };
        }
        {
          name = "javascript";
          language-servers = [ "typescript-language-server" ];
          auto-format = true;
          formatter = {
            command = "prettier";
            args = [ "--stdin-filepath" "%{buffer_name}" ];
          };
        }
        {
          name = "typescript";
          language-servers = [ "typescript-language-server" ];
          auto-format = true;
          formatter = {
            command = "prettier";
            args = [ "--stdin-filepath" "%{buffer_name}" ];
          };
        }
        {
          name = "kdl";
          language-servers = [ "kdl-lsp" ];
          auto-format = true;
          formatter = {
            command = "kdlfmt";
            args = [ "-" ];
          };
        }
        {
          name = "json";
          language-servers = [ "vscode-json-language-server" ];
          auto-format = true;
          formatter = {
            command = "prettier";
            args = [ "--stdin-filepath" "%{buffer_name}" ];
          };
        }
      ];
    };
  };
}