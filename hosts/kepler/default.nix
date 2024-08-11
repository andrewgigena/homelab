{ pkgs, ... }:

{
  imports = [
    ../common
    ./hardware.nix
    ../../modules/services
    ../../modules/desktop/kde.nix
    ../../modules/desktop/steam.nix
  ];

  networking.hostName = "kepler";
  boot.loader.systemd-boot.consoleMode = "max";
  networking.networkmanager.enable = true;
  powerManagement.enable = true;
  services.fwupd.enable = true;
  services.thermald.enable = true;
  hardware.enableAllFirmware = true;

  # Enable OpenCL on Radeon RX580
  hardware.amdgpu.opencl.enable = true;
  environment.systemPackages = with pkgs; [
    clinfo
  ];

  # Enable ROCm on Radeon RX580
  environment.variables = {
    ROC_ENABLE_PRE_VEGA = "1";
  };

  # Enable Vulkan on Radeon RX580 for 32 bit games
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  system.stateVersion = "24.05";
}
