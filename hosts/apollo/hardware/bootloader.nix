{ pkgs, ... }:

{
  # Bootloader and kernel
  boot = {
    supportedFilesystems = [ "btrfs" ];
    loader.systemd-boot.enable = true;
    loader.systemd-boot.consoleMode = "max";
    loader.systemd-boot.edk2-uefi-shell.enable = true;
    loader.systemd-boot.memtest86.enable = true;
    loader.systemd-boot.netbootxyz.enable = true;
    loader.efi.canTouchEfiVariables = true;
    plymouth.enable = true;
    initrd.systemd.enable = true;
    initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "ehci_pci"
      "nvme"
      "usb_storage"
      "usbhid"
      "sd_mod"
    ];
    initrd.kernelModules = [
      "dm-snapshot"
      "amdgpu"
    ];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "kvm-amd" ];
    extraModprobeConfig = "";
    extraModulePackages = [ ];
    kernelParams = [
      "quiet"
      "splash"
      "udev.log_level=0"
      "zswap.enabled=1"
      "zswap.compressor=zstd"
      "zswap.max_pool_percent=50"
    ];
  };
}
