{ pkgs, config, lib, modulesPath, ... }:

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
  boot.supportedFilesystems = [ "btrfs" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "max";
  boot.loader.efi.canTouchEfiVariables = true;

  # -----------------------
  # Initrd
  # -----------------------
  boot.plymouth.enable = true;
  boot.initrd.systemd.enable = true;
  boot.initrd.luks.devices."disk".device = "/dev/disk/by-uuid/82feac14-b199-429a-bffe-cff9306b1be9";
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" "amdgpu" ];

  # -----------------------
  # Kernel things
  # -----------------------
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "kvm-amd"];
  boot.extraModprobeConfig = "";
  boot.extraModulePackages = [ ];
  boot.kernelParams = [
    "quiet"
    "splash"
    "udev.log_level=0"
    "video=DP-1:1920x1080@60.00"
    "video=DP-2:1920x1080@60.00,panel_orientation=left_side_up"
    "video=HDMI-A-1:2560x1080@74.99"
    "kvm.enable_virt_at_load=0"
  ];

  # -----------------------
  # Main disk
  # -----------------------
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

  # -----------------------
  # Extra disks
  # TODO: Encrypt extra drives and unlock at boot
  # -----------------------
  # - Frodo - Samsung SSD 860 EVO 500GB
  fileSystems."/disks/frodo" = {
    device = "/dev/disk/by-uuid/ee9b5975-4368-4960-bcbb-1a30bff4208d";
    fsType = "btrfs";
    options = [ "compress=zstd" "noatime" "nofail" "x-systemd.device-timeout=5"];
  };

  # - Gandalf - FUJITSU MJA2320BH G2
  fileSystems."/disks/gandalf" = {
    device = "/dev/disk/by-uuid/75009ea3-cb1f-4cc0-ac88-e403e44e232a";
    fsType = "btrfs";
    options = [ "compress=zstd" "noatime" "nofail" "x-systemd.device-timeout=5"];
  };

  # - PostmarketOS - WDC WD10JPVX-60JC3T0
  fileSystems."/disks/postmarketos" = {
    device = "/dev/disk/by-uuid/0090e30f-007a-45ea-a23f-6868a371a41d";
    fsType = "ext4";
    options = [ "defaults" "noatime" "nofail" "async" "x-systemd.device-timeout=5"];
  };

  # -----------------------
  # Memory
  # -----------------------
  swapDevices = [ ];

  # -----------------------
  # Network
  # -----------------------
  networking.useDHCP = lib.mkDefault true;
  networking.hostName = "kepler";
  networking.networkmanager.enable = true;

  # -----------------------
  # Firmware
  # -----------------------
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.cpu.amd.updateMicrocode = true;
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

  nixpkgs.config.rocmSupport = true;
  hardware = {
    amdgpu.initrd.enable = true;
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        rocmPackages_5.clr        # OpenCL for RX580
        rocmPackages_5.clr.icd    # OpenCL for RX580
        rocmPackages_5.rocminfo
        rocmPackages_5.rocm-runtime
        mesa
        mesa.opencl
      ];
    };
  };

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages_5.clr}"
  ];

  services.ddccontrol.enable = true;

  # -----------------------
  # Audio
  # -----------------------
  systemd.user.services.disable-auto-mute = {
    enable = true;
    description = "Disable auto-mute so speakers can work with headphones plugged in";
    after = [ "graphical-session-pre.target" "pipewire.service" ];
    partOf = [ "graphical-session.target" "pipewire.service" ];
    wantedBy = [ "graphical-session.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.bash}/bin/bash -c 'for device in $(${pkgs.alsa-utils}/bin/aplay -L | grep -oP \"^[^\\s]*\"); do ${pkgs.alsa-utils}/bin/amixer -D \"$device\" sset \"Auto-Mute Mode\" Disabled 2>/dev/null || true; done'";
      Type = "oneshot";
    };
  };

  # -----------------------
  # CPU Emulation
  # -----------------------
  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
    "riscv64-linux"
  ];

  # -----------------------
  # VPN
  # -----------------------
  services.tailscale.extraSetFlags = [
    "--accept-routes"
  ];
}
