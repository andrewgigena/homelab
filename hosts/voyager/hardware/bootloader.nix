{ pkgs, ... }:

{
  # Bootloader and kernel
  boot = {
    supportedFilesystems = [ "btrfs" ];
    loader.grub.enable = true;
    loader.grub.efiSupport = true;
    loader.grub.device = "/dev/disk/by-id/wwn-0x50014ee208d0b014";
    loader.grub.gfxmodeBios = "1366x768";
    loader.grub.gfxpayloadBios = "keep";
    loader.grub.enableCryptodisk = true;
    loader.grub.memtest86.enable = true;
    plymouth.enable = true;
    initrd.systemd.enable = true;
    initrd.luks.devices."disk".device = "/dev/disk/by-uuid/e999efba-f8f1-4269-9dc5-3dc4b4b00bad";
    initrd.availableKernelModules = [
      "ehci_pci"
      "ahci"
      "xhci_pci"
      "usb_storage"
      "sd_mod"
      "sr_mod"
      "rtsx_pci_sdmmc"
    ];
    initrd.kernelModules = [
      "dm-snapshot"
      "i915"
      "radeon"
    ];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [
      "kvm-intel"
      "i915"
      "radeon"
    ];
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
