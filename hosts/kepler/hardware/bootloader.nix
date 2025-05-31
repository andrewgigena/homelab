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
    initrd.luks.devices."disk".device = "/dev/disk/by-uuid/82feac14-b199-429a-bffe-cff9306b1be9";
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
      "video=DP-1:1920x1080@60.00"
      "video=DP-2:1920x1080@60.00,panel_orientation=left_side_up"
      "video=HDMI-A-1:2560x1080@74.99"
      "kvm.enable_virt_at_load=0"
    ];
  };
}
