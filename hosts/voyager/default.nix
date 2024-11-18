{ pkgs, ... }:

{
  imports = [
    ../../modules/desktop/kde.nix
    ../../modules/services/audio.nix
    ../../modules/services/general.nix
    ../../modules/services/network.nix
    ../../modules/system
    ./hardware.nix
  ];

  networking.hostName = "voyager";
  networking.networkmanager.enable = true;

  # Firmware
  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableAllFirmware = true;
  services.fwupd.enable = true;

  # Power Management
  powerManagement.enable = true;
  services.thermald.enable = true;

  system.stateVersion = "24.05";
}

