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
      "usbhid"
      "usb_storage"
      "sd_mod"
      "sdhci_acpi"
    ];
    initrd.kernelModules = [
    ];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "kvm-intel" ];
    extraModprobeConfig = "";
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
