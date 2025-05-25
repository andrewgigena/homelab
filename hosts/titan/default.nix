{ ... }:
{
  imports = [
    ./hardware
  ];

  # Host-specific overrides
  networking.hostName = "titan";
  system.stateVersion = "25.05";
}
