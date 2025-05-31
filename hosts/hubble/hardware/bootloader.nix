{ pkgs, ... }:

{
  # Bootloader and kernel
  boot = {
    supportedFilesystems = [ "btrfs" ];
    loader.systemd-boot.enable = true;
    loader.systemd-boot.consoleMode = "keep";
    loader.systemd-boot.edk2-uefi-shell.enable = true;
    loader.systemd-boot.memtest86.enable = true;
    loader.systemd-boot.netbootxyz.enable = true;
    loader.efi.canTouchEfiVariables = true;
    plymouth.enable = true;
    initrd.systemd.enable = true;
    initrd.luks.devices."disk".device = "/dev/disk/by-uuid/01967b4c-767f-4ab5-a273-5f60e27ed319";
    initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "nvme"
      "usb_storage"
      "usbhid"
      "sd_mod"
    ];
    initrd.kernelModules = [
      "dm-snapshot"
    ];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "kvm-intel" ];
    extraModprobeConfig = ''
      options iwlwifi power_save=1
    '';
    extraModulePackages = [ ];
    kernelParams = [
      "quiet"
      "splash"
      "udev.log_level=0"
      "zswap.enabled=1"
      "zswap.compressor=zstd"
      "zswap.max_pool_percent=25"
    ];
  };
}
