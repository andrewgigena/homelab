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
      "intel_idle.max_cstate=1"
      "reboot=efi"
      "i915.enable_guc=2" # Enable GuC/HuC firmware loading
      "i915.enable_psr=1" # Panel Self Refresh for power savings
      "i915.enable_fbc=1" # Framebuffer compression
      "i915.fastboot=1" # Skip unnecessary mode sets at boot
      "i915.enable_dc=2" # Display power saving
    ];
  };
}
