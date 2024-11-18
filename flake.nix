{
  description = "Andrew's NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, nixos-hardware, ... } @ inputs:
  let
    inherit (self) outputs;
  in {
    nixosConfigurations = {
      mimir = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [
          ./hosts/mimir
          nixos-hardware.nixosModules.lenovo-thinkpad-t480
        ];
      };
      kepler = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [
          ./hosts/kepler
        ];
      };
      voyager = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [
          ./hosts/voyager
        ];
      };
    };

    # Home Manager configurations
    homeConfigurations = {
      "shadows@mimir" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs-unstable.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs outputs;};
        modules = [ 
           ./home
        ];
      };
      "shadows@kepler" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs-unstable.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs outputs;};
        modules = [ 
           ./home
        ];
      };
      "shadows@voyager" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs-unstable.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs outputs;};
        modules = [ 
           ./home
        ];
      };
    };
  };
}
