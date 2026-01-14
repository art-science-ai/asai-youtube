# IDE and editor-related packages
# LSP servers, formatters, linters, and other development tools
# Shared across all editors (nvim, nixvim, helix, etc.)
{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    # LSP servers
    nil # Nix LSP (legacy)
    nixd # Modern Nix LSP (preferred for Helix)
    lua-language-server # Lua LSP
    nodePackages.typescript-language-server # TypeScript/JavaScript LSP
    pyright # Python LSP
    rust-analyzer # Rust LSP
    marksman # Markdown LSP
    yaml-language-server # YAML LSP
    vscode-langservers-extracted # HTML, CSS, JSON, ESLint LSPs
    taplo # TOML LSP
    # kdl # KDL LSP

    # Formatters
    alejandra
    nixfmt-rfc-style # Nix formatter
    stylua # Lua formatter
    nodePackages.prettier # JavaScript/TypeScript/JSON/YAML/Markdown formatter
    black # Python formatter
    rustfmt # Rust formatter
    taplo # TOML formatter (also LSP)
    kdlfmt # KDL formatter

    # Linters
    shellcheck # Shell script linter

    # Debug adapters (for future DAP support)
    # lldb # For C/C++/Rust debugging

    # Additional editor tools
    tree-sitter # Tree-sitter CLI for grammar development
    neovim-remote
  ];
}
