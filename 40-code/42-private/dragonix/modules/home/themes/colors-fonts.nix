# Colors, fonts, and theming (Stylix, Catppuccin)
{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
let
  isLinux = !pkgs.stdenv.isDarwin;
  monoFont = pkgs.nerd-fonts.jetbrains-mono;
  sansSerifFont = pkgs.dejavu_fonts;
  serifFont = pkgs.dejavu_fonts;
  emojiFont = pkgs.noto-fonts-color-emoji;
  myFonts = with pkgs; [
    monoFont
    sansSerifFont
    noto-fonts
    emojiFont
  ];
in
{
  imports = [
    inputs.stylix.homeModules.stylix
    inputs.nix-colors.homeManagerModules.default
    inputs.catppuccin.homeModules.catppuccin
  ];

  # Install fonts to user profile (works on both Darwin and Linux)
  home.packages = myFonts;

  # Catppuccin configuration for supported programs
  catppuccin = {
    enable = false;
    flavor = "macchiato";
  };

  # Stylix configuration for other programs
  stylix = {
    enable = true;
    enableReleaseChecks = false;
    autoEnable = true;

    targets = {
      opencode.enable = false;
      gnome.enable = config.isDesktop && isLinux;
      gtk.enable = config.isDesktop;
      eog.enable = config.isDesktop && isLinux;
      gnome-text-editor.enable = config.isDesktop && isLinux;
    };

    # Colors: Catppuccin Macchiato (Base16)
    base16Scheme = lib.mkDefault "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
    # base16Scheme = inputs.nix-colors.colorSchemes.catppuccin-macchiato;
    polarity = lib.mkDefault "dark";

    # Fonts (safe and portable picks)
    fonts = {
      monospace = {
        package = monoFont;
        name = "JetBrainsMono Nerd Font";
      };
      sansSerif = {
        package = sansSerifFont;
        name = "DejaVu Sans";
      };
      serif = {
        package = serifFont;
        name = "DejaVu Serif";
      };
      emoji = {
        package = emojiFont;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = 12;
        desktop = 11;
        terminal = 12;
      };
    };
  };

  # Light theme specialization for easy switching
  specialisation.light.configuration = {
    stylix = {
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
      # base16Scheme = inputs.nix-colors.colorSchemes.catppuccin-frappe;
      polarity = "light";
    };
    catppuccin.flavor = lib.mkForce "latte";
  };

  # Font configuration using fontconfig (desktop only)
  fonts.fontconfig.enable = config.isDesktop;
}
