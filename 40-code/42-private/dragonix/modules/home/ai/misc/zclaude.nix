{
  config,
  lib,
  pkgs,
  ...
}: {
  # Custom binary for zclaude (z.ai proxy)
  home.packages = [
    (pkgs.writeShellScriptBin "zclaude" ''
      #!/usr/bin/env bash
      set -euo pipefail
      export OP_DISABLE_GUI="1"
      export ANTHROPIC_AUTH_TOKEN="953b6f9d64a3444e97b4106358e4e338.B28aGLgCKTOCeyxJ"
      export ANTHROPIC_BASE_URL="https://api.z.ai/api/anthropic"
      export API_TIMEOUT_MS="3000000"
      exec claude "$@"
    '')
  ];
}
