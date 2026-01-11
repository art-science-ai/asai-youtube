# =============================================
# Nix Flake for Cogitaas AI POC
# =============================================
# This file provides all system dependencies needed for Python parsing scripts.
#
# QUICK START:
#   1. Enter the environment:  nix develop
#   2. Run any script:          ./ai-plugins/doc-parsing/skills/pptx-to-markdown/scripts/convert_pptx_to_markdown.py
#
# HOW IT WORKS:
#   - System dependencies come from Nix (LibreOffice, poppler, etc.)
#   - Python packages are managed by uv via inline script metadata
#   - Each script is self-contained with # /// script /// dependencies
#
# COMMON COMMANDS:
#   nix develop                  # Enter the development environment
#   exit                         # Exit the environment
#   nix develop --command <cmd>  # Run a command in the environment
#   nix flake update             # Update flake inputs
#
# TROUBLESHOOTING:
#   - If scripts fail to import modules: run `rm -rf ~/.cache/uv` and re-enter nix develop
#   - Check LibreOffice is available: `soffice --version`
#   - Check poppler is available: `pdftoppm -h`
#
# REQUIREMENTS:
#   - Git repo initialized (flakes require git)
#   - Nix with flakes enabled (add 'experimental-features = nix-command flakes' to ~/.config/nix/nix.conf)
# =============================================

{
  description = "Cogitaas AI POC - Development environment with all system dependencies";

  inputs = {
    # Nix packages - using unstable branch for latest versions
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # flake-utils provides helper functions for multi-platform support
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    # Support multiple systems (x86_64-linux, aarch64-linux, x86_64-darwin, etc.)
    flake-utils.lib.eachDefaultSystem (system:
      let
        # Get nixpkgs for this system
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        # Default development shell
        devShells.default = pkgs.mkShell {
          # ====================================
          # BUILD INPUTS (System Dependencies)
          # ====================================
          # These packages are installed in the shell environment and available to all scripts.
          # Python package versions are managed per-script via uv inline metadata.

          buildInputs = with pkgs; [
            # Python 3.11+ runtime
            # Note: uv manages actual Python package versions per-script via inline metadata
            python311

            # uv - Fast Python package manager
            # Used by scripts via inline # /// script /// metadata
            # No need to pip install globally - each script declares its own dependencies
            uv

            # LibreOffice (provides soffice command)
            # Used by: pptx-to-markdown script
            # Converts PPTX files to PDF format for text/image extraction
            libreoffice-fresh

            # Poppler (provides pdftoppm command)
            # Used by: pptx-to-markdown script
            # Converts PDF pages to JPEG images for slide extraction
            poppler

            # C++ standard library (provides libstdc++.so.6)
            # Required by: markitdown, pandas, numpy, and other packages with C extensions
            # These packages need C++ libraries at runtime, which aren't always available in NixOS
            stdenv.cc.cc.lib

            # Git version control
            # Used for general development and version control
            git
          ];

          # ====================================
          # ENVIRONMENT CONFIGURATION
          # ====================================

          # shellHook runs when you enter nix develop
          shellHook = ''
            echo ""
            echo "=================================================================="
            echo "Cogitaas AI POC - Development Environment"
            echo "=================================================================="
            echo ""
            echo "Available system tools:"
            echo "  - Python 3.11+ (via nix)"
            echo "  - uv (Python package manager)"
            echo "  - LibreOffice (soffice command for PPTX conversion)"
            echo "  - poppler (pdftoppm for PDF to images)"
            echo ""
            echo "Python dependencies are managed via uv inline script metadata."
            echo "Scripts can be run directly with: ./scripts/script_name.py"
            echo ""
            echo "=================================================================="
            echo ""
          '';

          # LD_LIBRARY_PATH ensures packages with C extensions can find libstdc++.so.6
          # Without this, imports like 'import markitdown' or 'import pandas' will fail
          # with errors about missing shared libraries
          LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
        };
      }
    );
}
