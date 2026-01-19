{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      mgr = {
        ratio = [
          1
          2
          4
        ];
      };
      preview = {
        wrap = "yes";
      };
    plugins = {
      # "bypass.yazi" = pkgs.yaziPlugins.bypass;
      # "chmod.yazi" = pkgs.yaziPlugins.chmod;
      # "full-border.yazi" = pkgs.yaziPlugins.full-border;
      # "lazygit.yazi" = pkgs.yaziPlugins.lazygit;
      "mediainfo.yazi" = pkgs.yaziPlugins.mediainfo;
      # "no-status.yazi" = pkgs.yaziPlugins.no-status;
      # "ouch.yazi" = pkgs.yaziPlugins.ouch;
      # "restore.yazi" = pkgs.yaziPlugins.restore;
      # "smart-enter.yazi" = pkgs.yaziPlugins.smart-enter;
      # "toggle-pane.yazi" = pkgs.yaziPlugins.toggle-pane;
    };
    };

    # Plugins not working
    # yaziPlugins = {
    #   enable = true;
    #   plugins = {
    #     copy-file-contents.enable = true;
    #   };
    # };

  };

}
