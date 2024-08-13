{ pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ../../modules/system
    ../../modules/desktop/kde.nix
    ../../modules/services/audio.nix
    ../../modules/services/flatpak.nix
    ../../modules/services/general.nix
    ../../modules/services/kdeconnect.nix
    ../../modules/services/network.nix
    ../../modules/services/printing.nix
    ../../modules/services/ssd.nix
    ../../modules/services/steam.nix
    ../../modules/services/syncthing.nix
    ../../modules/services/virtualisation.nix
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

  # Environment Variables
  environment.sessionVariables = {
    ROC_ENABLE_PRE_VEGA = "1";
    RUSTICL_ENABLE = "radeonsi";
  };

  # Hardware things
  hardware = {
    amdgpu.initrd.enable = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        rocmPackages_5.clr        # OpenCL for RX580
        rocmPackages_5.clr.icd    # OpenCL for RX580
        mesa.opencl
      ];
    };
  };

  # Fix audio
  systemd.user.services.disable-auto-mute = {
    enable = true;
    description = "Disable auto-mute so speakers can work with headphones plugged in";
    after = [ "graphical-session-pre.target" "pipewire.service" ];
    partOf = [ "graphical-session.target" "pipewire.service" ];
    wantedBy = [ "graphical-session.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.alsa-utils}/bin/amixer -c 2 sset 'Auto-Mute Mode' Disabled";
      Type = "oneshot";
    };
  };

  system.stateVersion = "24.05";
}
