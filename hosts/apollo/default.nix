{ lib, pkgs, ... }:
{
  imports = [
    ./hardware
    ./system.nix
    ./services.nix
  ];

  # Host-specific overrides
  networking.hostName = "apollo";
  system.stateVersion = "24.05";
}
