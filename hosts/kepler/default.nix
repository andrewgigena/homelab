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
  services.thermald.enable = true;

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd.systemd.enable = true;
    plymouth.enable = true;
    kernelParams = [ "quiet" "splash" "udev.log_level=0" ];
    extraModprobeConfig = "options";
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
