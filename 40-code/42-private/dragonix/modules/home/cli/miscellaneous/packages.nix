# CLI packages - terminal utilities, development tools, compilers, language servers
{
  config,
  pkgs,
  lib,
  ...
}:
{
  # Terminal utility and development packages
  home.packages = with pkgs; [
    # ============================================================
    # CUSTOM PACKAGES (from overlays)
    # ============================================================
    # TODO: whisper-diarization is currently incomplete (missing Python deps)
    # Use with: uv run --directory ~/.local/share/whisper-diarization diarize.py
    whisper-diarization  # Speech recognition with speaker diarization (wrapper only)

    # ============================================================
    # TERMINAL UTILITIES AND CLI TOOLS (from nixpkgs)
    # ============================================================
    age
    atuin
    bind
    btop
    bat
    curl
    d2
    deploy-rs
    devenv
    devbox
    desktop-file-utils
    eza
    fastfetch
    fd
    ffmpeg
    fontconfig
    fzf
    gnutar
    gh
    gh-dash
    glances
    hcloud
    htop
    jujutsu
    just
    jq
    python313Packages.langfuse
    lazygit
    marp-cli
    mutagen
    ncdu
    nh
    pandoc
    pay-respects
    podman-compose
    rclone
    ripgrep
    sops
    ssh-to-age
    sshs
    stow
    subversion
    taplo
    tealdeer
    tesseract
    tmux
    todoist
    tree
    uv
    whisperx
    yt-dlp

    # ============================================================
    # DEVELOPMENT COMPILERS AND INTERPRETERS (from nixpkgs)
    # ============================================================
    cargo
    gcc
    lua
    luarocks
    tree-sitter
    imagemagick
    ghostscript
    tectonic
    nodePackages.mermaid-cli
    graphviz
    nodejs
    python3

    # ============================================================
    # LANGUAGE SERVERS AND FORMATTERS (from nixpkgs)
    # ============================================================
    nil # Nix LSP
    nixd # Alternative Nix LSP
    marksman # Markdown LSP
    yaml-language-server
    ruff # Python LSP/linter
    nixfmt-rfc-style
    nodePackages.typescript-language-server
    nodePackages.typescript
    stylua # Lua formatter
    vscode-langservers-extracted # HTML/CSS/JSON/ESLint
    nodePackages.markdownlint-cli2 # Markdown linter
    prettier
  ];
}
