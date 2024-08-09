{ pkgs, ... }:

{
  imports = [
    ../common
    ./hardware.nix
    ../../modules/services
    ../../modules/desktop/kde.nix
  ];

  networking.hostName = "kepler";
  networking.networkmanager.enable = true;
  hardware.enableAllFirmware = true;
  powerManagement.enable = true;
  services.thermald.enable = true;

  system.stateVersion = "24.05";
}
