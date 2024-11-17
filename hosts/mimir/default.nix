{ pkgs, ... }:

{
  imports = [
    ../../modules/desktop/kde.nix
    ../../modules/services/audio.nix
    ../../modules/services/flatpak.nix
    ../../modules/services/gaming.nix
    ../../modules/services/general.nix
    ../../modules/services/kdeconnect.nix
    ../../modules/services/network.nix
    ../../modules/services/printing.nix
    ../../modules/services/ssd.nix
    ../../modules/services/syncthing.nix
    ../../modules/services/qemu.nix
    ../../modules/services/docker.nix
    ../../modules/services/zerotier.nix
    ../../modules/system
    ./hardware.nix
  ];

  networking.hostName = "mimir";
  networking.networkmanager.enable = true;
  boot.extraModprobeConfig = ''
    options iwlwifi power_save=1
  '';
  boot.kernelParams = ''
    zswap.enabled=1
    zswap.compressor=zstd
    zswap.max_pool_percent=100
  '';

  # Environment Variables
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "i965";
    NIXOS_OZONE_WL = "1";
  };

  # Firmware
  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableAllFirmware = true;
  services.fwupd.enable = true;

  # Power Management
  powerManagement.enable = true;
  services.thinkfan.enable = true;
  services.thermald.enable = true;


  # Video acceleration
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };

  # OpenGL and Others
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
