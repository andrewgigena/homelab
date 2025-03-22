{
  description = "Andrew's NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, nixos-hardware, ... } @ inputs:
  let
    inherit (nixpkgs) lib;
  in {
    # -----------------------
    # Mimir - Workstation
    # -----------------------
    nixosConfigurations.mimir = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # Hardware-wide configurations
        ./hosts/mimir.nix

        # System-wide configurations
        ./modules/desktop/kde.nix
        ./modules/services/audio.nix
        ./modules/services/flatpak.nix
        ./modules/services/gaming.nix
        ./modules/services/general.nix
        ./modules/services/kdeconnect.nix
        ./modules/services/network.nix
        ./modules/services/printing.nix
        ./modules/services/ssd.nix
        ./modules/services/syncthing.nix
        ./modules/services/qemu.nix
        ./modules/services/docker.nix
        ./modules/services/zerotier.nix
        ./modules/system/bluetooth.nix
        ./modules/system/nix.nix
        ./modules/system/system.nix
        ./modules/system/users.nix

        # User-wide configurations
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { 
            pkgs-unstable = import nixpkgs-unstable {
              system = "x86_64-linux"; 
              config.allowUnfree = true;
            }; 
          };
          home-manager.users.shadows = lib.mkMerge [
            (import ./home/users/shadows.nix)
            (import ./home/packages/internet.nix)
            (import ./home/packages/multimedia.nix)
            (import ./home/packages/utilities.nix)
            (import ./home/packages/development.nix)
            (import ./home/packages/gaming.nix)
          ];
        }
      ];
    };

    # -----------------------
    # Kepler - Workstation
    # -----------------------
    nixosConfigurations.kepler = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # Hardware-wide configurations
        ./hosts/kepler.nix

        # System-wide configurations
        ./modules/desktop/kde.nix
        ./modules/services/audio.nix
        ./modules/services/flatpak.nix
        ./modules/services/gaming.nix
        ./modules/services/general.nix
        ./modules/services/kdeconnect.nix
        ./modules/services/network.nix
        ./modules/services/ollama.nix
        ./modules/services/printing.nix
        ./modules/services/ssd.nix
        ./modules/services/syncthing.nix
        ./modules/services/qemu.nix
        ./modules/services/docker.nix
        ./modules/services/zerotier.nix
        ./modules/system/bluetooth.nix
        ./modules/system/nix.nix
        ./modules/system/system.nix
        ./modules/system/users.nix

        # User-wide configurations
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { 
            pkgs-unstable = import nixpkgs-unstable {
              system = "x86_64-linux"; 
              config.allowUnfree = true;
            }; 
          };
          home-manager.users.shadows = lib.mkMerge [
            (import ./home/users/shadows.nix)
            (import ./home/packages/internet.nix)
            (import ./home/packages/multimedia.nix)
            (import ./home/packages/utilities.nix)
            (import ./home/packages/development.nix)
            (import ./home/packages/gaming.nix)
            (import ./home/packages/electronics.nix)
            (import ./home/packages/windows.nix)
          ];
        }
      ];
    };

    # -----------------------
    # Voyager - Gaming / Spare
    # -----------------------
    nixosConfigurations.voyager = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # Hardware-wide configurations
        ./hosts/voyager.nix

        # System-wide configurations
        ./modules/desktop/kde.nix
        ./modules/services/audio.nix
        ./modules/services/general.nix
        ./modules/services/network.nix
        ./modules/system/bluetooth.nix
        ./modules/system/nix.nix
        ./modules/system/system.nix
        ./modules/system/users.nix

        # User-wide configurations
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { 
            pkgs-unstable = import nixpkgs-unstable {
              system = "x86_64-linux"; 
              config.allowUnfree = true;
            }; 
          };
          home-manager.users.shadows = lib.mkMerge [
            (import ./home/users/shadows.nix)
            (import ./home/packages/internet.nix)
            (import ./home/packages/multimedia.nix)
            (import ./home/packages/utilities.nix)
            (import ./home/packages/gaming.nix)
          ];
        }
      ];
    };

    # -----------------------
    # Apollo - Server
    # -----------------------
    nixosConfigurations.apollo = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # Hardware-wide configurations
        ./hosts/apollo.nix

        # System-wide configurations
        ./modules/services/general.nix
        ./modules/services/network.nix
	./modules/services/zerotier.nix
	./modules/services/tailscale.nix
	./modules/system/nix.nix
        ./modules/system/system.nix
        ./modules/system/users.nix

        # Server configuration
        ./modules/server/apollo.nix

        # User-wide configurations
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.shadows = lib.mkMerge [
            (import ./home/users/shadows.nix)
          ];
        }
      ];
    };
  };
}
