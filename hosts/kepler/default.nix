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
    ../../modules/services/ollama.nix
    ../../modules/services/printing.nix
    ../../modules/services/ssd.nix
    ../../modules/services/syncthing.nix
    ../../modules/services/virtualisation.nix
    ../../modules/services/zerotier.nix
    ../../modules/system
    ./hardware.nix
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
  nixpkgs.config.rocmSupport = true;
  hardware = {
    amdgpu.initrd.enable = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        rocmPackages_5.clr        # OpenCL for RX580
        rocmPackages_5.clr.icd    # OpenCL for RX580
        rocmPackages_5.rocminfo
        rocmPackages_5.rocm-runtime
        mesa.opencl
      ];
    };
  };

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages_5.clr}"
  ];

  # Fix audio
  systemd.user.services.disable-auto-mute = {
    enable = true;
    description = "Disable auto-mute so speakers can work with headphones plugged in";
    after = [ "graphical-session-pre.target" "pipewire.service" ];
    partOf = [ "graphical-session.target" "pipewire.service" ];
    wantedBy = [ "graphical-session.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.bash}/bin/bash -c 'for device in $(${pkgs.alsa-utils}/bin/aplay -L | grep -oP \"^[^\\s]*\"); do ${pkgs.alsa-utils}/bin/amixer -D \"$device\" sset \"Auto-Mute Mode\" Disabled 2>/dev/null || true; done'";
      Type = "oneshot";
    };
  };

  system.stateVersion = "24.05";
}
