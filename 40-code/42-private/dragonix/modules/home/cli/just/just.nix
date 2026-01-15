{ config, lib, pkgs, ... }:

{
  # Source the justfile
  home.file.".config/just/justfile".source = ./justfile;

  # Custom wrapper for just that uses the central justfile
  home.packages = [
    (pkgs.writeShellScriptBin "j" ''
      #!/usr/bin/env bash
      set -euo pipefail
      exec just --justfile ~/.config/just/justfile --working-directory . "$@"
    '')
  ];
}
