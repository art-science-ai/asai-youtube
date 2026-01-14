{ ... }:
{
  # Development and testing services - enable/disable by commenting/uncommenting imports
  imports = [
    # ./glances.nix
    # ./obsidian.nix
    ./n8n.nix
    ./openwebui.nix

    # ./homepage.nix
    # ./homeassistant.nix
    # ./ollama.nix
    # ./librechat.nix
    # ./cockpit.nix
    # ./netdata.nix
  ];
}
