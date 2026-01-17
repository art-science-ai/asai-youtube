{
  imports = [
    ./git-jj.nix
    ./nh.nix
    # ./npm-config.nix  # Disabled: manage npm packages manually instead
    ./packages.nix
    ./programs.nix
    ./shell-config.nix
    ./yazi.nix
  ];
}