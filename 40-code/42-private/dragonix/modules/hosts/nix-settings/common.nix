{ config, lib, ... }:

{
  # Declare the determinateNix option (available on all platforms for consistency)
  options.determinateNix = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Determinate Nix mode (Darwin-only: disables nix-darwin's Nix daemon)";
    };
  };

  config = {
    # Allow unfree packages globally
    nixpkgs.config.allowUnfree = true;

    # Nix settings (cross-platform)
    nix.settings.experimental-features = "nix-command flakes";
    nix.settings.trusted-users = [
      "root"
      "nikhilmaddirala"
      "@admin"
    ];
    nix.settings.download-buffer-size = 268435456;

    # Add binary caches for faster builds
    nix.settings.substituters = [
      "https://cache.nixos.org/"
      "https://cache.numtide.com"
      "https://nix-community.cachix.org"
      "https://nixpkgs-unfree.cachix.org"
      "https://devenv.cachix.org"
      "https://pre-commit-hooks.cachix.org"
      "https://niri.cachix.org"
      "https://vicinae.cachix.org"
    ];
    nix.settings.trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nixpkgs-unfree.cachix.org-1:hqvoInulhbV4nJ9yJOEr+4wxhDV4xq2d1DK7S6Nj6rs="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "pre-commit-hooks.cachix.org-1:Pkk3Panw5AW24TOv6kz3PvLhlH8puAsJTBbOPmBo7Rc="
      "niri.cachix.org-1:WpQXhrkV3C4XR5MHGka0xXG+9MNM6UAL0vFM1McbR9E="
      "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
    ];
  };
}