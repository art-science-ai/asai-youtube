{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [ kanata ];

  home.file.".config/kanata/kanata.kbd".source = ./kanata.kbd;

  systemd.user.services.kanata = {
    Unit = {
      Description = "Kanata keyboard remapper";
    };
    Service = {
      ExecStart = "${pkgs.kanata}/bin/kanata -c %h/.config/kanata/kanata.kbd";
      Restart = "always";
      RestartTriggers = [config.home.file.".config/kanata/kanata.kbd".source];
    };
    Install = {
      WantedBy = ["default.target"];
    };
  };

  # NOTE: kanata upstream is at v1.10.0+, but latest nixpkgs version is v1.9.0.
  # The improved config (kanata-v1.10.kbd) uses tap-hold-tap-keys which prevents
  # character transposition during fast typing (e.g., "fast" → "fats").
  #
  # To use the improved config, either:
  # 1. Wait for nixpkgs to update to kanata v1.10.0+, then change source to ./kanata-v1.10.kbd
  # 2. Add a custom overlay to pin kanata to a newer version (e.g., from kanata's own flake)
}