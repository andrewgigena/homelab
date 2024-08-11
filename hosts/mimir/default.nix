{ pkgs, ... }:

{
  imports = [
    ../common
    ./hardware.nix
    ../../modules/services
    ../../modules/desktop/kde.nix
    ../../modules/desktop/steam.nix
  ];

  networking.hostName = "mimir";
  networking.networkmanager.enable = true;
  hardware.enableAllFirmware = true;
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "i965";
    NIXOS_OZONE_WL = "1";
  };
  powerManagement.enable = true;
  services.fwupd.enable = true;
  services.thinkfan.enable = true;
  services.thermald.enable = true;

  boot.extraModprobeConfig = "thinkpad_acpi fan_control=1";

  # Video acceleration
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };

  # OpenGL and Others
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-vaapi-driver # Video acceleration
      libvdpau-va-gl # Video acceleration
      intel-compute-runtime # OpenCL
    ];
  };

  system.stateVersion = "24.05";
}
