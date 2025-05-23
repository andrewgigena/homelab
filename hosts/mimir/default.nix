{ lib, pkgs, ... }:
{
  imports = [
    ./hardware
    ./system.nix
  ];

  # Host-specific overrides
  networking.hostName = "mimir";
  system.stateVersion = "24.05";
}
