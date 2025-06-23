{ ... }:
{
  imports = [
    ./hardware
    ./voyager.nix
  ];

  # Host-specific overrides
  networking.hostName = "voyager";
  system.stateVersion = "24.05";
}
