# Nixvim-based NvChad configuration
# 100% declarative Nix configuration - no Lua files!
# Creates a 'nixvim' binary with NvChad-like features
{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
let
  # Complete nixvim configuration
  nvimConfig = {
    # Note: LSP servers, formatters, and linters come from PATH
    # They are installed via ide/packages.nix and shared across all editors
    # This follows Option 2: external packages approach

    # Vim options - NvChad defaults
    opts = {
      # UI
      number = true;
      relativenumber = true;
      numberwidth = 2;
      ruler = false;

      # Indentation
      expandtab = true;
      shiftwidth = 2;
      smartindent = true;
      tabstop = 2;
      softtabstop = 2;

      # Search
      ignorecase = true;
      smartcase = true;
      hlsearch = true;
      incsearch = true;

      # UI enhancements
      cursorline = true;
      signcolumn = "yes";
      cmdheight = 1;
      updatetime = 250;
      timeoutlen = 400;

      # Splits
      splitbelow = true;
      splitright = true;

      # File handling
      undofile = true;
      swapfile = false;

      # Mouse and clipboard
      mouse = "a";
      clipboard = "unnamedplus";

      # Display
      fillchars = {
        eob = " ";
      };
      wrap = false;
      termguicolors = true;
    };

    # Global variables
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    # Colorscheme - Catppuccin Macchiato (matches existing theme)
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "macchiato";
        transparent_background = false;
        integrations = {
          cmp = true;
          gitsigns = true;
          nvimtree = true;
          treesitter = true;
          telescope = {
            enabled = true;
          };
          which_key = true;
          indent_blankline = {
            enabled = true;
            colored_indent_levels = true;
          };
          native_lsp = {
            enabled = true;
            virtual_text = {
              errors = [ "italic" ];
              hints = [ "italic" ];
              warnings = [ "italic" ];
              information = [ "italic" ];
            };
            underlines = {
              errors = [ "underline" ];
              hints = [ "underline" ];
              warnings = [ "underline" ];
              information = [ "underline" ];
            };
          };
        };
      };
    };

    # Plugins
    plugins = {
      # UI Plugins
      lualine = {
        enable = true;
        settings = {
          options = {
            theme = "catppuccin";
            component_separators = {
              left = "|";
              right = "|";
            };
            section_separators = {
              left = "";
              right = "";
            };
            globalstatus = true;
          };
          sections = {
            lualine_a = [ "mode" ];
            lualine_b = [
              "branch"
              "diff"
              "diagnostics"
            ];
            lualine_c = [ "filename" ];
            lualine_x = [
              "encoding"
              "fileformat"
              "filetype"
            ];
            lualine_y = [ "progress" ];
            lualine_z = [ "location" ];
          };
        };
      };

      bufferline = {
        enable = true;
        settings = {
          options = {
            mode = "buffers";
            themable = true;
            separator_style = "thin";
            close_command = "bdelete! %d";
            right_mouse_command = "bdelete! %d";
            left_mouse_command = "buffer %d";
            offsets = [
              {
                filetype = "NvimTree";
                text = "File Explorer";
                highlight = "Directory";
                separator = true;
              }
            ];
            diagnostics = "nvim_lsp";
            show_buffer_close_icons = true;
            show_close_icon = true;
            always_show_bufferline = true;
          };
        };
      };

      which-key = {
        enable = true;
        settings = {
          delay = 400;
          icons = {
            breadcrumb = "»";
            separator = "➜";
            group = "+";
          };
          spec = [
            {
              __unkeyed-1 = "<leader>f";
              group = "Find (Telescope)";
            }
            {
              __unkeyed-1 = "<leader>g";
              group = "Git";
            }
            {
              __unkeyed-1 = "<leader>l";
              group = "LSP";
            }
            {
              __unkeyed-1 = "<leader>b";
              group = "Buffers";
            }
          ];
        };
      };

      indent-blankline = {
        enable = true;
        settings = {
          scope = {
            enabled = true;
            show_start = true;
            show_end = false;
          };
        };
      };

      web-devicons.enable = true;

      # Navigation Plugins
      telescope = {
        enable = true;
        extensions = {
          fzf-native = {
            enable = true;
          };
          ui-select = {
            enable = true;
          };
        };
        settings = {
          defaults = {
            prompt_prefix = " ";
            selection_caret = " ";
            path_display = [ "truncate" ];
            sorting_strategy = "ascending";
            layout_config = {
              horizontal = {
                prompt_position = "top";
                preview_width = 0.55;
              };
              vertical = {
                mirror = false;
              };
              width = 0.87;
              height = 0.80;
              preview_cutoff = 120;
            };
            file_ignore_patterns = [
              "^.git/"
              "^node_modules/"
              "^target/"
              "^result/"
            ];
          };
        };
        keymaps = {
          "<leader>ff" = {
            action = "find_files";
            options.desc = "Find files";
          };
          "<leader>fg" = {
            action = "live_grep";
            options.desc = "Live grep";
          };
          "<leader>fb" = {
            action = "buffers";
            options.desc = "Find buffers";
          };
          "<leader>fh" = {
            action = "help_tags";
            options.desc = "Find help";
          };
          "<leader>fo" = {
            action = "oldfiles";
            options.desc = "Recent files";
          };
          "<leader>fw" = {
            action = "grep_string";
            options.desc = "Find word under cursor";
          };
        };
      };

      nvim-tree = {
        enable = true;
        settings = {
          disable_netrw = true;
          hijack_netrw = true;
          hijack_cursor = true;
          sync_root_with_cwd = true;
          update_focused_file = {
            enable = true;
            update_root = false;
          };
          view = {
            adaptive_size = false;
            side = "left";
            width = 30;
            preserve_window_proportions = true;
          };
          git = {
            enable = true;
            ignore = false;
          };
          filesystem_watchers = {
            enable = true;
          };
          actions = {
            open_file = {
              resize_window = true;
            };
          };
          renderer = {
            root_folder_label = false;
            highlight_git = true;
            indent_markers = {
              enable = true;
            };
            icons = {
              show = {
                file = true;
                folder = true;
                folder_arrow = true;
                git = true;
              };
            };
          };
        };
      };

      # Editor Enhancement Plugins
      treesitter = {
        enable = true;
        settings = {
          highlight = {
            enable = true;
            additional_vim_regex_highlighting = false;
          };
          indent = {
            enable = true;
          };
        };
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          bash
          c
          css
          go
          html
          javascript
          json
          lua
          markdown
          nix
          python
          rust
          toml
          tsx
          typescript
          vim
          yaml
        ];
      };

      treesitter-context = {
        enable = true;
        settings = {
          max_lines = 3;
        };
      };

      gitsigns = {
        enable = true;
        settings = {
          signs = {
            add = {
              text = "│";
            };
            change = {
              text = "│";
            };
            delete = {
              text = "_";
            };
            topdelete = {
              text = "‾";
            };
            changedelete = {
              text = "~";
            };
            untracked = {
              text = "┆";
            };
          };
          current_line_blame = false;
          current_line_blame_opts = {
            virt_text = true;
            virt_text_pos = "eol";
          };
        };
      };

      nvim-autopairs = {
        enable = true;
        settings = {
          check_ts = true;
          ts_config = {
            lua = [
              "string"
              "source"
            ];
            javascript = [
              "string"
              "template_string"
            ];
          };
        };
      };

      comment.enable = true;

      nvim-surround.enable = true;

      toggleterm = {
        enable = true;
        settings = {
          size = 20;
          open_mapping = "[[<c-\\>]]";
          hide_numbers = true;
          shade_terminals = true;
          start_in_insert = true;
          insert_mappings = true;
          terminal_mappings = true;
          persist_size = true;
          direction = "float";
          close_on_exit = true;
          shell = "zsh";
          float_opts = {
            border = "curved";
          };
        };
      };

      # LSP Configuration
      # All LSP servers are installed via ide/packages.nix
      # Nixvim finds them via PATH lookup - no bundling into the derivation
      lsp = {
        enable = true;
        servers = {
          # Nix LSP (provided by nil package)
          nil_ls = {
            enable = true;
            settings = {
              formatting = {
                command = [ "nixfmt" ];
              };
            };
          };

          # Lua LSP (provided by lua-language-server package)
          lua_ls = {
            enable = true;
            settings = {
              Lua = {
                diagnostics = {
                  globals = [ "vim" ];
                };
                workspace = {
                  library = [
                    "\${3rd}/luv/library"
                    "~/.config/nvim-nvchad"
                  ];
                };
              };
            };
          };

          # TypeScript/JavaScript LSP (provided by nodePackages.typescript-language-server)
          ts_ls.enable = true;

          # Python LSP (provided by pyright package)
          pyright.enable = true;

          # Rust LSP (provided by rust-analyzer package)
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };

          # Markdown LSP (provided by marksman package)
          marksman.enable = true;

          # YAML LSP (provided by yaml-language-server package)
          yamlls.enable = true;

          # HTML/CSS/JSON LSPs (provided by vscode-langservers-extracted package)
          html.enable = true;
          cssls.enable = true;
          jsonls.enable = true;
        };

        keymaps = {
          diagnostic = {
            "<leader>ld" = "open_float";
            "[d" = "goto_prev";
            "]d" = "goto_next";
            "<leader>lq" = "setloclist";
          };
          lspBuf = {
            "gD" = "declaration";
            "gd" = "definition";
            "K" = "hover";
            "gi" = "implementation";
            "<C-k>" = "signature_help";
            "<leader>D" = "type_definition";
            "<leader>rn" = "rename";
            "<leader>ca" = "code_action";
            "gr" = "references";
            "<leader>lf" = "format";
          };
        };
      };

      lsp-lines.enable = true;

      # Completion
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          snippet = {
            expand = ''
              function(args)
                require('luasnip').lsp_expand(args.body)
              end
            '';
          };
          mapping = {
            __raw = ''
              cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ['<Tab>'] = cmp.mapping(function(fallback)
                  if cmp.visible() then
                    cmp.select_next_item()
                  elseif require("luasnip").expand_or_jumpable() then
                    require("luasnip").expand_or_jump()
                  else
                    fallback()
                  end
                end, { "i", "s" }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                  if cmp.visible() then
                    cmp.select_prev_item()
                  elseif require("luasnip").jumpable(-1) then
                    require("luasnip").jump(-1)
                  else
                    fallback()
                  end
                end, { "i", "s" }),
              })
            '';
          };
          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
        };
      };

      luasnip.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;
      cmp_luasnip.enable = true;
    };

    # Keymaps - NvChad-style bindings
    keymaps = [
      # General
      {
        mode = "n";
        key = "<Esc>";
        action = "<cmd>noh<CR>";
        options.desc = "Clear highlights";
      }

      # Better window navigation
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w>h";
        options.desc = "Window left";
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w>j";
        options.desc = "Window down";
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>k";
        options.desc = "Window up";
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w>l";
        options.desc = "Window right";
      }

      # Resize windows
      {
        mode = "n";
        key = "<C-Up>";
        action = "<cmd>resize +2<CR>";
        options.desc = "Increase window height";
      }
      {
        mode = "n";
        key = "<C-Down>";
        action = "<cmd>resize -2<CR>";
        options.desc = "Decrease window height";
      }
      {
        mode = "n";
        key = "<C-Left>";
        action = "<cmd>vertical resize -2<CR>";
        options.desc = "Decrease window width";
      }
      {
        mode = "n";
        key = "<C-Right>";
        action = "<cmd>vertical resize +2<CR>";
        options.desc = "Increase window width";
      }

      # Buffer navigation
      {
        mode = "n";
        key = "<Tab>";
        action = "<cmd>BufferLineCycleNext<CR>";
        options.desc = "Next buffer";
      }
      {
        mode = "n";
        key = "<S-Tab>";
        action = "<cmd>BufferLineCyclePrev<CR>";
        options.desc = "Previous buffer";
      }
      {
        mode = "n";
        key = "<leader>x";
        action = "<cmd>bdelete<CR>";
        options.desc = "Close buffer";
      }

      # File explorer
      {
        mode = "n";
        key = "<C-n>";
        action = "<cmd>NvimTreeToggle<CR>";
        options.desc = "Toggle file explorer";
      }
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>NvimTreeFocus<CR>";
        options.desc = "Focus file explorer";
      }

      # Save file
      {
        mode = "n";
        key = "<C-s>";
        action = "<cmd>w<CR>";
        options.desc = "Save file";
      }

      # Better indenting
      {
        mode = "v";
        key = "<";
        action = "<gv";
        options.desc = "Indent left";
      }
      {
        mode = "v";
        key = ">";
        action = ">gv";
        options.desc = "Indent right";
      }

      # Move lines
      {
        mode = "v";
        key = "J";
        action = ":m '>+1<CR>gv=gv";
        options.desc = "Move line down";
      }
      {
        mode = "v";
        key = "K";
        action = ":m '<-2<CR>gv=gv";
        options.desc = "Move line up";
      }

      # Git signs
      {
        mode = "n";
        key = "<leader>gp";
        action = "<cmd>Gitsigns preview_hunk<CR>";
        options.desc = "Preview hunk";
      }
      {
        mode = "n";
        key = "<leader>gb";
        action = "<cmd>Gitsigns toggle_current_line_blame<CR>";
        options.desc = "Toggle line blame";
      }
    ];
  };

  # Create standalone nixvim package
  nvimNvchad = inputs.nixvim.legacyPackages.${pkgs.system}.makeNixvimWithModule {
    inherit pkgs;
    module = nvimConfig;
  };

  # Wrapper named 'nixvim' to avoid conflict with existing nvim
  nxcBinary = pkgs.writeShellScriptBin "nxc" ''
    export NVIM_APPNAME=nvim-nvchad
    exec ${nvimNvchad}/bin/nvim "$@"
  '';
in
{
  home.packages = [ nxcBinary ];
}
