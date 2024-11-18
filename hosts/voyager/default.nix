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

  # Environment Variables
  environment.sessionVariables = {
    ROC_ENABLE_PRE_VEGA = "1";
    RUSTICL_ENABLE = "radeonsi";
  };

  # OpenGL and Others
  hardware.amdgpu.initrd.enable = true;
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      intel-vaapi-driver # Video acceleration
      libvdpau-va-gl # Video acceleration
      intel-compute-runtime # OpenCL
      mesa.opencl
    ];
  };

  system.stateVersion = "24.05";
}

