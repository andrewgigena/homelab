{ lib, pkgs, ... }:
{
  imports = [
    ./hardware
    ./system.nix
  ];

  # Host-specific overrides
  networking.hostName = "kepler";
  system.stateVersion = "24.05";
}
