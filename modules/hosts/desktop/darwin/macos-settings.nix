# System preferences and defaults for macOS
{
  config,
  pkgs,
  ...
}:
{
  security.pam.services.sudo_local.touchIdAuth = true;
}
