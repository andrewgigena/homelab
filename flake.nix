{
  description = "Andrew's HomeLab";

  inputs = {
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    thinkpad_t480_fp = {
      url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor?ref=24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-unstable,
      determinate,
      thinkpad_t480_fp,
      ...
    }:
    let
      inherit (nixpkgs) lib;

      pkgsUnstable =
        system:
        import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };

      mkHost =
        {
          name,
          roles ? [ ],
          extraModules ? [ ],
          useNixDeterminateSystem ? true,
        }:
        lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            pkgs-unstable = pkgsUnstable "x86_64-linux";
          };
          modules =
            (lib.optional useNixDeterminateSystem determinate.nixosModules.default)
            ++ [
              ./nixos.nix
              ./hosts/${name}
            ]
            ++ (map (role: ./roles/${role}.nix) roles)
            ++ extraModules;
        };
    in
    {
      nixosConfigurations = {
        apollo = mkHost {
          name = "apollo";
          roles = [
            "containers"
            "virtualization"
          ];
          useNixDeterminateSystem = true;
        };

        voyager = mkHost {
          name = "voyager";
          roles = [
            "gaming"
            "workstation"
          ];
          useNixDeterminateSystem = false;
        };

        kepler = mkHost {
          name = "kepler";
          roles = [
            "containers"
            "creative"
            "development"
            "electronics"
            "gaming"
            "machine-learning"
            "virtualization"
            "workstation"
          ];
          useNixDeterminateSystem = true;
        };

        hubble = mkHost {
          name = "hubble";
          roles = [
            "containers"
            "development"
            "gaming"
            "workstation"
          ];
          extraModules = [
            thinkpad_t480_fp.nixosModules."06cb-009a-fingerprint-sensor"
          ];
          useNixDeterminateSystem = true;
        };

        titan = mkHost {
          name = "titan";
          roles = [ ];
          useNixDeterminateSystem = false;
        };
      };
    };
}
