{ lib, pkgs, ... }:
{
  imports = [
    ./hardware
    ./system.nix
  ];

  # Host-specific overrides
  networking.hostName = "hubble";
  system.stateVersion = "24.05";
}
