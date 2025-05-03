{
  description = "Andrew's NixOS config";

  inputs = {
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    # Thinkpad T480
    nixos-06cb-009a-fingerprint-sensor = {
      url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor?ref=24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    determinate,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    nixos-hardware,
    nixos-06cb-009a-fingerprint-sensor,
    ...
  } @ inputs:
  let
    inherit (nixpkgs) lib;
  in {
    # -----------------------
    # Mimir - Workstation
    # -----------------------
    nixosConfigurations.mimir = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        pkgs-unstable = import inputs.nixpkgs-unstable {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
      };
      modules = [
        determinate.nixosModules.default

        # Hardware configurations
        ./hosts/mimir.nix
        ./common/hardware/audio.nix
        ./common/hardware/bluetooth.nix
        ./common/hardware/printing.nix
        ./common/hardware/ssd.nix

        # Fingerprint reader
        nixos-06cb-009a-fingerprint-sensor.nixosModules."06cb-009a-fingerprint-sensor"

        # System configurations
        ./common/configurations/desktop.nix
        ./common/configurations/network.nix
        ./common/configurations/system.nix

        # System users
        ./common/users/system/shadows.nix

        # Users configurations
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
            (import ./common/users/home/shadows.nix)
          ];
        }

        # System services
        ./common/services/adb.nix
        ./common/services/docker.nix
        ./common/services/flatpak.nix
        ./common/services/gaming.nix
        ./common/services/kdeconnect.nix
        ./common/services/qemu.nix
        ./common/services/syncthing.nix
        ./common/services/tailscale.nix
        ./common/services/zerotier.nix

        # Packages
        (import ./packages/internet.nix)
        (import ./packages/multimedia.nix)
        (import ./packages/utilities.nix)
        (import ./packages/development.nix)
        (import ./packages/gaming.nix)
      ];
    };

    # -----------------------
    # Kepler - Workstation
    # -----------------------
    nixosConfigurations.kepler = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        pkgs-unstable = import inputs.nixpkgs-unstable {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
      };
      modules = [
        determinate.nixosModules.default

        # Hardware configurations
        ./hosts/kepler.nix
        ./common/hardware/audio.nix
        ./common/hardware/bluetooth.nix
        ./common/hardware/printing.nix
        ./common/hardware/ssd.nix

        # System configurations
        ./common/configurations/desktop.nix
        ./common/configurations/network.nix
        ./common/configurations/system.nix

        # System users
        ./common/users/system/shadows.nix

        # Users configurations
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
            (import ./common/users/home/shadows.nix)
          ];
        }

        # Services
        ./common/services/adb.nix
        ./common/services/docker.nix
        ./common/services/flatpak.nix
        ./common/services/gaming.nix
        ./common/services/kdeconnect.nix
        ./common/services/ollama.nix
        ./common/services/qemu.nix
        ./common/services/syncthing.nix
        ./common/services/tailscale.nix
        ./common/services/waydroid.nix
        ./common/services/zerotier.nix

        # Packages
        (import ./packages/internet.nix)
        (import ./packages/multimedia.nix)
        (import ./packages/utilities.nix)
        (import ./packages/development.nix)
        (import ./packages/gaming.nix)
        (import ./packages/electronics.nix)
        (import ./packages/kubernetes.nix)
        (import ./packages/windows.nix)
      ];
    };

    # -----------------------
    # Voyager - Gaming / Spare
    # -----------------------
    nixosConfigurations.voyager = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        pkgs-unstable = import inputs.nixpkgs-unstable {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
      };
      modules = [
        determinate.nixosModules.default

        # Hardware configurations
        ./hosts/voyager.nix
        ./common/hardware/audio.nix
        ./common/hardware/bluetooth.nix

        # System configurations
        ./common/configurations/desktop.nix
        ./common/configurations/network.nix
        ./common/configurations/system.nix

        # System users
        ./common/users/system/shadows.nix

        # Users configurations
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
            (import ./common/users/home/shadows.nix)
          ];
        }

        # Packages
        (import ./packages/internet.nix)
        (import ./packages/multimedia.nix)
        (import ./packages/utilities.nix)
        (import ./packages/gaming.nix)
      ];
    };

    # -----------------------
    # Apollo - Server
    # -----------------------
    nixosConfigurations.apollo = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        pkgs-unstable = import inputs.nixpkgs-unstable {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
      };
      modules = [
        determinate.nixosModules.default

        # Hardware configurations
        ./hosts/apollo.nix

        # System configurations
        ./common/configurations/network.nix
        ./common/configurations/system.nix

        # System users
        ./common/users/system/shadows.nix

        # Users configurations
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.shadows = lib.mkMerge [
            (import ./common/users/home/shadows.nix)
          ];
        }

        # Services
        ./hosts/apollo_services.nix
       	./common/services/tailscale.nix
       	./common/services/zerotier.nix
      ];
    };
  };
}
