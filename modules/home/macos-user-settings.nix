# macOS user-level system preferences
# Applies sensible defaults for macOS Finder, Dock, keyboard, etc.
{ config, pkgs, lib, ... }:

{
  home.activation.userSpecificMacOSSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    # Screencapture
    $DRY_RUN_CMD defaults write com.apple.screencapture "location" -string "''${HOME}/Pictures/Screenshots"
    $DRY_RUN_CMD defaults write com.apple.screencapture "type" -string "png"
    $DRY_RUN_CMD defaults write com.apple.screencapture "disable-shadow" -bool "true"

    # Finder
    $DRY_RUN_CMD defaults write com.apple.finder "AppleShowAllFiles" -bool "true"
    $DRY_RUN_CMD defaults write com.apple.finder "AppleShowAllExtensions" -bool "true"
    $DRY_RUN_CMD defaults write com.apple.finder "ShowPathbar" -bool "true"
    $DRY_RUN_CMD defaults write com.apple.finder "FXDefaultSearchScope" -string "SCcf"
    $DRY_RUN_CMD defaults write com.apple.finder "FXPreferredViewStyle" -string "Nlsv"

    # Dock
    $DRY_RUN_CMD defaults write com.apple.dock "autohide" -bool "true"
    $DRY_RUN_CMD defaults write com.apple.dock "tilesize" -int "36"
    $DRY_RUN_CMD defaults write com.apple.dock "show-process-indicators" -bool "true"

    # Keyboard
    $DRY_RUN_CMD defaults write NSGlobalDomain "KeyRepeat" -int "2"
    $DRY_RUN_CMD defaults write NSGlobalDomain "InitialKeyRepeat" -int "15"
    $DRY_RUN_CMD defaults write NSGlobalDomain "ApplePressAndHoldEnabled" -bool "false"

    # Activity Monitor
    $DRY_RUN_CMD defaults write com.apple.ActivityMonitor "UpdatePeriod" -int "2"
    $DRY_RUN_CMD defaults write com.apple.ActivityMonitor "IconType" -int "5"

    # Trackpad
    $DRY_RUN_CMD defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad "Clicking" -bool "true"
    $DRY_RUN_CMD defaults write com.apple.AppleMultitouchTrackpad "Clicking" -bool "true"
    $DRY_RUN_CMD defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad "TrackpadThreeFingerDrag" -bool "true"
    $DRY_RUN_CMD defaults write com.apple.AppleMultitouchTrackpad "TrackpadThreeFingerDrag" -bool "true"
  '';
}
