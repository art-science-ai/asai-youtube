{ lib, config, system, ... }:
let
  isLinux = lib.hasSuffix "-linux" system;
  isDarwin = lib.hasSuffix "-darwin" system;
in
{
  # Platform-specific group for secret ownership
  config.secretGroup = if isDarwin then "staff" else "wheel";

  imports = [
    ./common.nix
  ] ++ lib.optional isLinux ./linux.nix;
}