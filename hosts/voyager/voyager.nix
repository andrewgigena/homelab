{
  pkgs,
  lib,
  modulesPath,
  ...
}:

{
  # -----------------------
  # Nix things
  # -----------------------
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  system.stateVersion = "24.05";

  # -----------------------
  # Bootloader
  # -----------------------
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "/dev/disk/by-id/wwn-0x50014ee208d0b014";
  boot.loader.grub.gfxmodeBios = "1366x768";
  boot.loader.grub.gfxpayloadBios = "keep";
  boot.loader.grub.enableCryptodisk = true;

  # -----------------------
  # Initrd
  # -----------------------
  boot.plymouth.enable = true;
  boot.initrd.systemd.enable = true;
  boot.initrd.luks.devices."disk".device = "/dev/disk/by-uuid/e999efba-f8f1-4269-9dc5-3dc4b4b00bad";
  boot.initrd.availableKernelModules = [
    "ehci_pci"
    "ahci"
    "xhci_pci"
    "usb_storage"
    "sd_mod"
    "sr_mod"
    "rtsx_pci_sdmmc"
  ];
  boot.initrd.kernelModules = [
    "dm-snapshot"
    "i915"
    "radeon"
  ];

  # -----------------------
  # Kernel things
  # -----------------------
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [
    "kvm-intel"
    "i915"
    "radeon"
  ];
  # AMDGPU driver don't work on this system
  # Checked on /linux/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c at amdgpu_unsupported_pciidlist
  boot.blacklistedKernelModules = [ "amdgpu" ];
  boot.extraModulePackages = [ ];
  boot.kernelParams = [
    "quiet"
    "splash"
    "udev.log_level=0"
    "zswap.enabled=1"
    "zswap.compressor=zstd"
    "zswap.max_pool_percent=100"
  ];

  # -----------------------
  # Main disk
  # -----------------------
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/9dc6379d-f8d5-41cd-ad6d-8d0687346f32";
    fsType = "btrfs";
    options = [
      "subvol=@root"
      "compress=zstd"
      "noatime"
    ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/9dc6379d-f8d5-41cd-ad6d-8d0687346f32";
    fsType = "btrfs";
    options = [
      "subvol=@home"
      "compress=zstd"
      "noatime"
    ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/9dc6379d-f8d5-41cd-ad6d-8d0687346f32";
    fsType = "btrfs";
    options = [
      "subvol=@nix"
      "compress=zstd"
      "noatime"
    ];
  };

  fileSystems."/persist" = {
    device = "/dev/disk/by-uuid/9dc6379d-f8d5-41cd-ad6d-8d0687346f32";
    fsType = "btrfs";
    options = [
      "subvol=@persist"
      "compress=zstd"
      "noatime"
    ];
    neededForBoot = true;

  };

  fileSystems."/var/log" = {
    device = "/dev/disk/by-uuid/9dc6379d-f8d5-41cd-ad6d-8d0687346f32";
    fsType = "btrfs";
    options = [
      "subvol=@log"
      "compress=zstd"
      "noatime"
    ];
    neededForBoot = true;
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/632D-6D3C";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  # -----------------------
  # Memory
  # -----------------------
  swapDevices = [
    {
      device = "/swapfile";
      size = 4 * 1024;
    }
  ];

  # -----------------------
  # Network
  # -----------------------
  networking.hostName = "voyager";
  networking.networkmanager.enable = true;
  networking.useDHCP = lib.mkDefault true;

  # -----------------------
  # Firmware
  # -----------------------
  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableAllFirmware = true;
  services.fwupd.enable = true;

  # -----------------------
  # Power Management
  # -----------------------
  powerManagement.enable = true;
  services.thermald.enable = true;

  # -----------------------
  # GPU Support
  # -----------------------
  environment.sessionVariables = {
    ROC_ENABLE_PRE_VEGA = "1";
    RUSTICL_ENABLE = "radeonsi";
  };

  # OpenGL and Others
  hardware.amdgpu.initrd.enable = true;
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-vaapi-driver # Video acceleration
      libvdpau-va-gl # Video acceleration
      intel-compute-runtime # OpenCL
      mesa.opencl
    ];
  };
}
