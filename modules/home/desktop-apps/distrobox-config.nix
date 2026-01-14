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

    aurPackageNames = map (p: p.package) aurPackages;
    exportedBins = map (p: p.bin) aurPackages;

    # Container name
    name = "archlinux";

    # Give the container its own writable home (avoids RO ~/.config issues)
    containerHome = "${config.home.homeDirectory}/.local/share/distrobox-homes/${name}";

    # NixOS host CA bundle exposed inside container by Distrobox
    hostCABundle = "/run/host/etc/ssl/certs/ca-bundle.crt";

    aurList = lib.concatStringsSep " " aurPackageNames;

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
        additional_flags = [
          "--home"
          containerHome
        ];

        # Export these to the host (distrobox-export wrapper handled by distrobox)
        exported_bins = exportedBins;

        # Desktop entries for GUI apps you export
        entry = true;

        # This just ensures pacman has tools for building AUR packages
        additional_packages = [
          "git"
          "base-devel"
          "ca-certificates"
          "openssl"
        ];

        # Runs when you enter/start the container (should be idempotent)
        init_hooks = [
          # 1) Make HTTPS “just work” for git/curl/etc. in a NixOS-hosted container.
          #    (Avoids needing ~/.config/git/config and avoids RO issues.)
          ''
            if [ -r "${hostCABundle}" ]; then
              sudo mkdir -p /etc/profile.d
              sudo tee /etc/profile.d/host-ca.sh >/dev/null <<'EOF'
              export SSL_CERT_FILE=${hostCABundle}
              export CURL_CA_BUNDLE=${hostCABundle}
              export GIT_SSL_CAINFO=${hostCABundle}
              EOF
            fi
          ''

          # 2) Ensure base deps exist (idempotent via --needed)
          "sudo pacman -S --needed --noconfirm git base-devel ca-certificates openssl"

          # 3) Install yay if missing (idempotent check)
          ''
            if ! command -v yay >/dev/null 2>&1; then
              rm -rf /tmp/yay
              git clone https://aur.archlinux.org/yay.git /tmp/yay
              (cd /tmp/yay && makepkg -si --noconfirm)
            fi
          ''

          # 4) Ensure declared AUR packages are installed (idempotent via --needed)
          ''
            # Use --needed so reruns don't rebuild/reinstall already-present packages.
            # Use --noconfirm for non-interactive activation/entry.
            yay -S --needed --noconfirm ${aurList}
          ''
        ];
      };
    };

    # Declaratively create/update containers after HM applies config.
    # Use --replace so edits to the config converge on the desired state.
    home.activation.createDistroboxContainers = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      export PATH="${config.home.homeDirectory}/.nix-profile/bin:$PATH"

      ${pkgs.systemd}/bin/systemctl --user start podman.socket || true

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
