# General guidelines
- CRITICAL: Always read the README.md, AGENTS.md, and CONTRIBUTING.md in the root directory of the project.
- CRITICAL: Always check for available MCP tools that could help with the task at hand.

# Markdown formatting rules
- Use sentence case for headings.
- Avoid using bold and italics formatting anywhere.
- Avoid using numbered lists for bullet points; use unordered lists instead.
- Avoid using too many header levels. Use nested bullet points instead.

# Project Overview

This directory contains Nikhil's Neovim configuration, built on `kickstart.nvim` with `NixCats` integration. The configuration emphasizes understandability, modularity, and minimalism. It aims to provide a robust, declarative development environment by managing LSP servers and development tools via Nix.

# Building and Running

This is a Neovim configuration, not a standalone application that requires building or running in the traditional sense. To "run" this project, you need to have Neovim installed and configured to use this directory as its configuration source.

-   **Neovim Configuration**: This configuration is loaded by Neovim when it starts.
-   **NixCats Integration**: LSP servers and development tools are declaratively managed via Nix. This means they are defined in a Nix configuration (e.g., `home/common/nvim.nix`) rather than being auto-installed by tools like Mason.

# Development Conventions

-   **Structure**: The configuration is highly modular, organized into `lua/core/` for core Neovim settings and `lua/plugins/` for individual plugin configurations.
-   **Styling**: Code formatting is enforced using `stylua` with the following rules:
    -   `column_width = 160`
    -   `line_endings = "Unix"`
    -   `indent_type = "Spaces"`
    -   `indent_width = 2`
    -   `quote_style = "AutoPreferSingle"`
    -   `call_parentheses = "None"`
-   **Plugin Management**: `lazy.nvim` is used for plugin management. Key commands include:
    -   `:Lazy` - View plugin status
    -   `:Lazy update` - Update all plugins
    -   `:Lazy clean` - Remove unused plugins
-   **Adding New Languages**: Involves configuring LSP servers (`lua/plugins/lsp-config.lua`), Treesitter parsers (`lua/plugins/treesitter.lua`), and formatters (`lua/plugins/lsp-autoformat.lua`). LSP servers and formatters should be managed via Nix.
-   **Adding New Plugins**: Create a new file in `lua/plugins/` returning a plugin specification.
-   **Customization**: Keymaps, options, and autocommands can be added by editing `lua/core/keymaps.lua`, `lua/core/options.lua`, and `lua/core/autocommands.lua` respectively.
