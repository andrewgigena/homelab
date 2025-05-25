{ ... }:
{
  imports = [
    ./hardware.nix
  ];

  # Host-specific overrides
  networking.hostName = "titan";
  system.stateVersion = "25.05";
}
