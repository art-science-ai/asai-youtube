{
  description = "Modular Nix configuration for Darwin and NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    deploy-rs.url = "github:serokell/deploy-rs";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    nix-rosetta-builder = {
      url = "github:cpick/nix-rosetta-builder";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    catppuccin.url = "github:catppuccin/nix";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";
    impermanence.url = "github:nix-community/impermanence";
    nix-colors.url = "github:misterio77/nix-colors";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    # nixvim - DO NOT use follows for standalone/makeNixvimWithModule usage
    # See: https://nix-community.github.io/nixvim/user-guide/faq.html
    nixvim.url = "github:nix-community/nixvim";
    nix-yazi-plugins.url = "github:lordkekz/nix-yazi-plugins";
    nix-yazi-plugins.inputs.nixpkgs.follows = "nixpkgs";
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri.url = "github:sodiboo/niri-flake";
    niri.inputs.nixpkgs.follows = "nixpkgs";
    vicinae.url = "github:vicinaehq/vicinae";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.inputs.home-manager.follows = "home-manager";
    xremap-flake.url = "github:xremap/nix-flake";
    xremap-flake.inputs.nixpkgs.follows = "nixpkgs";
    # AI agent packages from numtide
    # Note: Don't use follows for nixpkgs here - llm-agents needs its own pinned version
    # to ensure build tools like fetchPnpmDeps are available
    llm-agents.url = "github:numtide/llm-agents.nix";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      darwin,
      # nix-flatpak,
      ...
    }:

    {
      # macOS configurations
      darwinConfigurations = {
        meleys = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = {
            inherit inputs;
            system = "aarch64-darwin";
          };
          modules = [ ./hosts/meleys/default.nix ];
        };
        moondancer = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = {
            inherit inputs;
            system = "aarch64-darwin";
          };
          modules = [ ./hosts/moondancer/default.nix ];
        };
      };

      # NixOS configurations
      nixosConfigurations = {
        seasmoke = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
            system = "x86_64-linux";
          };
          modules = [ ./hosts/seasmoke ];
        };
        vermax = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
            system = "x86_64-linux";
          };
          modules = [ ./hosts/vermax ];
        };
      };

      # Standalone Home Manager configurations
      homeConfigurations = {
        "nikhilmaddirala@meleys" = home-manager.lib.homeManagerConfiguration {
           pkgs = nixpkgs.legacyPackages.aarch64-darwin.extend (import ./overlays/whisper-diarization.nix);
           extraSpecialArgs = {
             inherit inputs;
             hostname = "meleys";
             system = "aarch64-darwin";
           };
           modules = [ ./home/nikhilmaddirala-meleys.nix ];
         };

        "nikhilmaddirala@moondancer" = home-manager.lib.homeManagerConfiguration {
           pkgs = nixpkgs.legacyPackages.aarch64-darwin.extend (import ./overlays/whisper-diarization.nix);
           extraSpecialArgs = {
             inherit inputs;
             hostname = "moondancer";
             system = "aarch64-darwin";
           };
           modules = [ ./home/nikhilmaddirala-moondancer.nix ];
         };

        "nikhilmaddirala@seasmoke" = home-manager.lib.homeManagerConfiguration {
           pkgs = nixpkgs.legacyPackages.x86_64-linux.extend (import ./overlays/whisper-diarization.nix);
           extraSpecialArgs = {
             inherit inputs;
             hostname = "seasmoke";
             system = "x86_64-linux";
           };
           modules = [ ./home/nikhilmaddirala-seasmoke.nix ];
         };

        "nikhilmaddirala@vermax" = home-manager.lib.homeManagerConfiguration {
           pkgs = nixpkgs.legacyPackages.x86_64-linux.extend (import ./overlays/whisper-diarization.nix);
           extraSpecialArgs = {
             inherit inputs;
             hostname = "vermax";
             system = "x86_64-linux";
           };
           modules = [ ./home/nikhilmaddirala-vermax.nix ];
         };

      };

      deploy.nodes = {
        seasmoke = {
          hostname = "seasmoke";
          sshUser = "nikhilmaddirala";
          remoteBuild = true;
          autoRollback = true;
          magicRollback = true;
          confirmTimeout = 300; # 5 minutes (default is 30 seconds)

          profiles.system = {
            user = "root";
            path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.seasmoke;
          };
          profiles.home = {
            user = "nikhilmaddirala";
            path =
              inputs.deploy-rs.lib.x86_64-linux.activate.home-manager
                self.homeConfigurations."nikhilmaddirala@seasmoke";
          };
        };
        vermax = {
          hostname = "vermax";
          sshUser = "nikhilmaddirala";
          remoteBuild = false;
          autoRollback = true;
          magicRollback = true;
          confirmTimeout = 300;

          profiles.system = {
            user = "root";
            path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.vermax;
          };
          profiles.home = {
            user = "nikhilmaddirala";
            path =
              inputs.deploy-rs.lib.x86_64-linux.activate.home-manager
                self.homeConfigurations."nikhilmaddirala@vermax";
          };
        };
      };

      # Configuration checks (system and home-manager builds)
      checks = {
        # Linux checks (system config validation + home configs)
        x86_64-linux = {
          "seasmoke-config" = self.nixosConfigurations.seasmoke.config.system.build.toplevel;
          "home-seasmoke" = self.homeConfigurations."nikhilmaddirala@seasmoke".activationPackage;
          "vermax-config" = self.nixosConfigurations.vermax.config.system.build.toplevel;
          "home-vermax" = self.homeConfigurations."nikhilmaddirala@vermax".activationPackage;
        };

        # Darwin configuration checks (system + home configs)
        aarch64-darwin = {
          meleys-config = self.darwinConfigurations.meleys.config.system.build.toplevel;
          "home-meleys" = self.homeConfigurations."nikhilmaddirala@meleys".activationPackage;
          moondancer-config = self.darwinConfigurations.moondancer.config.system.build.toplevel;
          "home-moondancer" = self.homeConfigurations."nikhilmaddirala@moondancer".activationPackage;
        };
      };

      devShells = {
        aarch64-darwin = {
          python = nixpkgs.legacyPackages.aarch64-darwin.mkShell {
            buildInputs = with nixpkgs.legacyPackages.aarch64-darwin; [
              python3
              bash
            ];
            shellHook = ''
              export PATH="${nixpkgs.legacyPackages.aarch64-darwin.python3}/bin:${nixpkgs.legacyPackages.aarch64-darwin.bash}/bin"
              unset DYLD_LIBRARY_PATH
              unset DYLD_FALLBACK_LIBRARY_PATH
              echo "hello from python nix dev shell"
            '';
          };

          node = nixpkgs.legacyPackages.aarch64-darwin.mkShell {
            buildInputs = with nixpkgs.legacyPackages.aarch64-darwin; [
              nodejs
              bash
            ];
            shellHook = ''
              export PATH="${nixpkgs.legacyPackages.aarch64-darwin.nodejs}/bin:${nixpkgs.legacyPackages.aarch64-darwin.bash}/bin"
              unset DYLD_LIBRARY_PATH
              unset DYLD_FALLBACK_LIBRARY_PATH
              echo "hello from node nix dev shell"
            '';
          };
        };

        x86_64-linux = {
          python = nixpkgs.legacyPackages.x86_64-linux.mkShell {
            pure = true;
            buildInputs = with nixpkgs.legacyPackages.x86_64-linux; [
              python3
            ];
            shellHook = ''
              echo "hello from python nix dev shell"
            '';
          };

          node = nixpkgs.legacyPackages.x86_64-linux.mkShell {
            pure = true;
            buildInputs = with nixpkgs.legacyPackages.x86_64-linux; [
              nodejs
            ];
            shellHook = ''
              echo "hello from node nix dev shell"
            '';
          };
        };
      };

      # Custom overlays
      overlays = {
        whisper-diarization = import ./overlays/whisper-diarization.nix;
        default = self.overlays.whisper-diarization;
      };

      # Custom packages
      packages = {
        x86_64-linux = {
          whisper-diarization =
            (nixpkgs.legacyPackages.x86_64-linux.extend self.overlays.whisper-diarization).whisper-diarization;
        };
        aarch64-darwin = {
          whisper-diarization =
            (nixpkgs.legacyPackages.aarch64-darwin.extend self.overlays.whisper-diarization).whisper-diarization;
        };
      };

    };
}
