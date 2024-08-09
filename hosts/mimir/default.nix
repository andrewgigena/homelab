{ pkgs, ... }:

{
  imports = [
    ../common
    ./hardware.nix
    ../../modules/services
    ../../modules/desktop/kde.nix
  ];

  networking.hostName = "mimir";
  networking.networkmanager.enable = true;

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "i965";
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
    enableAllFirmware = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
  };

  powerManagement.enable = true;
  services.thinkfan.enable = true;
  services.thermald.enable = true;

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd.systemd.enable = true;
    initrd.luks.devices = {
      root = {
        device = "/dev/disk/by-uuid/01967b4c-767f-4ab5-a273-5f60e27ed319";
      };
    };
    plymouth.enable = true;
    kernelParams = [ "quiet" "splash" "udev.log_level=0" ];
    extraModprobeConfig = "options thinkpad_acpi fan_control=1";
  };

  # Video acceleration
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-vaapi-driver
      libvdpau-va-gl
    ];
  };

  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
    libraries = with pkgs; [
      stdenv.cc.cc
      fuse3
      openssl
      curl
      libxkbcommon
      libudev-zero
      libappindicator-gtk3
      libdrm
      libglvnd
      libusb1
      libuuid
      libxml2
      libinput
      mesa
      fontconfig
      freetype
      sqlite
    ];
  };

  system.stateVersion = "24.05";
}
