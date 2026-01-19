# Homebrew package management for macOS
{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
{
  # Set primary user for nix-darwin (required for Homebrew)
  system.primaryUser = lib.mkDefault "nikhilmaddirala";

  # Standard PATH for macOS launchd user environment
  launchd.user.envVariables.PATH = lib.mkAfter [
    "/run/current-system/sw/bin"
    "/etc/profiles/per-user/${config.system.primaryUser}/bin"
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
    "/usr/local/bin"
    "/usr/bin"
    "/usr/sbin"
    "/bin"
    "/sbin"
  ];

  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = "nikhilmaddirala";
    autoMigrate = true;
  };

  homebrew.enable = true;
  homebrew.onActivation.autoUpdate = true;
  homebrew.onActivation.upgrade = true;
  homebrew.onActivation.cleanup = "zap";

  homebrew.taps = [
    "FelixKratz/formulae"
    "nikitabobko/tap"
  ];

  homebrew.brews = [
    "mas"
    "FelixKratz/formulae/borders"
    "FelixKratz/formulae/sketchybar"
    "ollama"
    "displayplacer"
    "coreutils"
    "pngpaste"
  ];

  homebrew.casks = [
    "1password"
    "1password-cli"
    "alt-tab"
    "blackhole-2ch"
    "displaylink"
    # "docker"
    "finicky"
    "ghostty"
    "google-drive"
    "hammerspoon"
    "fastrepl/hyprnote/hyprnote@nightly"
    "iterm2"
    "iina"
    "karabiner-elements"
    "libreoffice"
    "microsoft-edge"
    "moonlight"
    "monitorcontrol"
    "nikitabobko/tap/aerospace"
    "notunes"
    "obs"
    "obsidian"
    "raycast"
    "selfcontrol"
    "signal"
    "todoist-app"
    "voiceink"
    "visual-studio-code"
    "zed"
    # "zen"
  ];

  homebrew.masApps = {
    # "Logic Pro" = 634148309;
    # "Final Cut Pro" = 424389933;
  };
}
