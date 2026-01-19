{
  config,
  pkgs,
  lib,
  ...
}:

lib.mkIf (!pkgs.stdenv.isDarwin) (
  let
    # Declarative list of AUR packages + (optional) exported binary names
    aurPackages = [
      {
        package = "claude-code";
        bin = "claude";
      }
      {
        package = "zen-browser-bin";
        bin = "zen-browser";
      }
    ];

    # Extract just the binary names for exporting
    exportedBins = map (p: p.bin) aurPackages;

    # Container name
    name = "archlinux";

    # Give the container its own writable home (avoids RO ~/.config issues)
    containerHome = "${config.home.homeDirectory}/.local/share/distrobox-homes/${name}";

  in
  {
    home.packages = [
      pkgs.podman
      pkgs.distrobox
    ];

    # Rootless podman for distrobox
    services.podman.enable = true;

    programs.distrobox = {
      enable = true;
      settings.container_manager = "podman";

      containers.${name} = {
        image = "archlinux:latest";

        # Critical: keep container home writable and isolated
        # Note: additional_flags must be a string, not a list, to keep --home and its path together
        additional_flags = "--home ${containerHome}";

        # Export these to the host (distrobox-export wrapper handled by distrobox)
        # Note: exported_bins as space-separated string
        exported_bins = lib.concatStringsSep " " exportedBins;

        # Desktop entries for GUI apps you export
        entry = true;

        # This just ensures pacman has tools for building AUR packages
        # Note: Space-separated string of packages
        additional_packages = "git base-devel ca-certificates openssl";

        # Runs when you enter/start the container (should be idempotent)
        # Note: Init hooks must be simple strings, not multi-line with heredocs
        init_hooks = [
          # 1) Make HTTPS "just work" for git/curl/etc. in a NixOS-hosted container
          "if [ -r /run/host/etc/ssl/certs/ca-bundle.crt ]; then sudo mkdir -p /etc/profile.d && echo 'export SSL_CERT_FILE=/run/host/etc/ssl/certs/ca-bundle.crt' | sudo tee /etc/profile.d/host-ca.sh >/dev/null && echo 'export CURL_CA_BUNDLE=/run/host/etc/ssl/certs/ca-bundle.crt' | sudo tee -a /etc/profile.d/host-ca.sh >/dev/null && echo 'export GIT_SSL_CAINFO=/run/host/etc/ssl/certs/ca-bundle.crt' | sudo tee -a /etc/profile.d/host-ca.sh >/dev/null; fi"

          # 2) Ensure base deps exist (idempotent via --needed)
          "sudo pacman -S --needed --noconfirm git base-devel ca-certificates openssl"

          # 3) Install yay if missing (idempotent check)
          "if ! command -v yay >/dev/null 2>&1; then rm -rf /tmp/yay && git clone https://aur.archlinux.org/yay.git /tmp/yay && (cd /tmp/yay && makepkg -si --noconfirm); fi"

          # 4) Ensure declared AUR packages are installed (idempotent via --needed)
          "yay -S --needed --noconfirm claude-code zen-browser-bin"
        ];
      };
    };

    # Declaratively create/update containers after HM applies config.
    # Use --replace so edits to the config converge on the desired state.
    home.activation.createDistroboxContainers = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      export PATH="${config.home.homeDirectory}/.nix-profile/bin:$PATH"

      # Start and wait for podman socket to be ready
      ${pkgs.systemd}/bin/systemctl --user start podman.socket

      # Wait for podman to be available (max 10 seconds)
      timeout=10
      while ! ${pkgs.podman}/bin/podman info >/dev/null 2>&1; do
        if [ $timeout -le 0 ]; then
          echo "Error: podman did not become ready in time"
          exit 1
        fi
        sleep 1
        timeout=$((timeout - 1))
      done

      # Home Manager's distrobox module writes the assemble file at:
      #   ~/.config/distrobox/containers.ini
      #
      # --replace makes this converge to your declarative definition.
      ${pkgs.distrobox}/bin/distrobox assemble create \
        --file "${config.home.homeDirectory}/.config/distrobox/containers.ini" \
        --replace || true
    '';
  }
)
