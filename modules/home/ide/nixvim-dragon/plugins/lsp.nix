# LSP server configurations
# Minimal configs for language servers installed via Nix
{
  plugins = {
    ######################
    ## 1. LSP servers  ##
    ######################
    lsp = {
      enable = true;

      servers = {
        # Nix LSP
        nixd = {
          enable = true;
          settings = {
            nixpkgs = {
              expr = "import <nixpkgs> { }";
            };
            formatting = {
              command = ["alejandra"];
            };
            options = {
              nixos = {
                expr = "(builtins.getFlake (builtins.getEnv \"HOME\" + \"/.config/nix-config\")).nixosConfigurations.vermax.options";
              };
              darwin = {
                expr = "(builtins.getFlake (builtins.getEnv \"HOME\" + \"/.config/nix-config\")).darwinConfigurations.moondancer.options";
              };
              home_manager = {
                expr = "(builtins.getFlake (builtins.getEnv \"HOME\" + \"/.config/nix-config\")).homeConfigurations.\"nikhilmaddirala@vermax\".options";
              };
            };
          };
        };

        # Lua LSP (with vim globals)
        lua_ls = {
          enable = true;
          settings = {
            Lua = {
              diagnostics = {
                globals = ["vim"];
              };
            };
          };
        };

        # Python LSP
        pyright.enable = true;

        # TypeScript/JavaScript LSP
        ts_ls.enable = true;

        # Markdown LSP
        marksman.enable = true;

        # YAML LSP
        yamlls.enable = true;

        # JSON LSP
        jsonls.enable = true;

        # Bash
        bashls.enable = true;
      };
    };

    ########################################
    ## 2. LSP-based formatting on save   ##
    ########################################
    # Uses vim.lsp.buf.format() under the hood.
    lsp-format = {
      enable = true;
    };

    #################################
    ## 3. Extra formatters (optional)
    #################################
    conform-nvim = {
      enable = true;
      # Only use where you *need* an external formatter.
      settings = {
        formatters_by_ft = {
          lua = ["stylua"];
          nix = ["alejandra"];
          javascript = ["prettier"];
          typescript = ["prettier"];
        };
      };
    };

    ################################
    ## 4. Linters (optional)      ##
    ################################
    # If LSP diagnostics are enough, you can skip this.
    lint = {
      enable = true;

      lintersByFt = {
        sh = ["shellcheck"];
        python = ["ruff"];
        javascript = ["eslint"];
        typescript = ["eslint"];
      };
    };
  };
}
