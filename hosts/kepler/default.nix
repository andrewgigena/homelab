{ pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ../../modules/system
    ../../modules/services
    ../../modules/desktop/kde.nix
    ../../modules/desktop/steam.nix
  ];

  networking.hostName = "kepler";
  networking.networkmanager.enable = true;
  boot.loader.systemd-boot.consoleMode = "max";

  # Firmware
  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableAllFirmware = true;
  services.fwupd.enable = true;

  # Power Management
  powerManagement.enable = true;
  services.thermald.enable = true;

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
