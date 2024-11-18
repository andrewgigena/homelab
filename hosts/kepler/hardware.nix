{ config, lib, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
  
  boot.supportedFilesystems = [ "btrfs" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.systemd.enable = true;
  boot.plymouth.enable = true;
  boot.kernelParams = [ "quiet" "splash" "udev.log_level=0" ];
  boot.extraModprobeConfig = "";
  boot.initrd.luks.devices."disk".device = "/dev/disk/by-uuid/82feac14-b199-429a-bffe-cff9306b1be9";
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" "amdgpu" ];
  boot.kernelModules = [ "kvm-amd"];
  boot.extraModulePackages = [ ];
  boot.kernelParams = [
    "video=DP-1:1920x1080@60.00"
    "video=DP-2:1920x1080@60.00,panel_orientation=left_side_up"
    "video=HDMI-A-1:2560x1080@74.99"
  ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/8bbf763e-0613-48b6-8ed0-d15a83510946";
    fsType = "btrfs";
    options = [ "subvol=@root" "compress=zstd" "noatime"];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/8bbf763e-0613-48b6-8ed0-d15a83510946";
    fsType = "btrfs";
    options = [ "subvol=@home" "compress=zstd" "noatime" ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/8bbf763e-0613-48b6-8ed0-d15a83510946";
    fsType = "btrfs";
    options = [ "subvol=@nix" "compress=zstd" "noatime" ];
  };

  fileSystems."/persist" = {
    device = "/dev/disk/by-uuid/8bbf763e-0613-48b6-8ed0-d15a83510946";
    fsType = "btrfs";
    options = [ "subvol=@persist" "compress=zstd" "noatime" ];
    neededForBoot = true;
  };

  fileSystems."/var/log" = {
    device = "/dev/disk/by-uuid/8bbf763e-0613-48b6-8ed0-d15a83510946";
    fsType = "btrfs";
    options = [ "subvol=@log" "compress=zstd" "noatime" ];
    neededForBoot = true;
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/A901-69EC";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=0022" ];
  };

  # TODO: Encrypt extra drives
  # Frodo - Samsung SSD 860 EVO 500GB
  fileSystems."/disks/frodo" = {
    device = "/dev/disk/by-uuid/ee9b5975-4368-4960-bcbb-1a30bff4208d";
    fsType = "btrfs";
    options = [ "compress=zstd" "noatime" "nofail" "x-systemd.device-timeout=5"];
  };

  # Gandalf - FUJITSU MJA2320BH G2
  fileSystems."/disks/gandalf" = {
    device = "/dev/disk/by-uuid/75009ea3-cb1f-4cc0-ac88-e403e44e232a";
    fsType = "btrfs";
    options = [ "compress=zstd" "noatime" "nofail" "x-systemd.device-timeout=5"];
  };

  # Legolas - WDC WD10JPVX-60JC3T0
  fileSystems."/disks/legolas" = {
    device = "/dev/disk/by-uuid/0090e30f-007a-45ea-a23f-6868a371a41d";
    fsType = "btrfs";
    options = [ "compress=zstd" "noatime" "nofail" "x-systemd.device-timeout=5"];
  };

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
