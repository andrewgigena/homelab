{ pkgs, lib, modulesPath, ... }:

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
  boot.loader.efi.canTouchEfiVariables = true;

  # -----------------------
  # Initrd
  # -----------------------
  boot.plymouth.enable = true;
  boot.initrd.systemd.enable = true;
  boot.initrd.luks.devices."disk".device = "/dev/disk/by-uuid/01967b4c-767f-4ab5-a273-5f60e27ed319";
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];

  # -----------------------
  # Kernel things
  # -----------------------
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "kvm-intel"];
  boot.extraModprobeConfig = ''
    options iwlwifi power_save=1
  '';
  boot.extraModulePackages = [ ];
  boot.kernelParams = [
    "quiet"
    "splash"
    "udev.log_level=0"
    "zswap.enabled=1"
    "zswap.compressor=zstd"
    "zswap.max_pool_percent=25"
  ];

  # -----------------------
  # Main disk
  # -----------------------
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/5406a663-c73f-4a2b-9b75-e54bd8f74b90";
    fsType = "btrfs";
    options = [ "subvol=@root" "compress=zstd" "noatime"];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/5406a663-c73f-4a2b-9b75-e54bd8f74b90";
    fsType = "btrfs";
    options = [ "subvol=@home" "compress=zstd" "noatime" ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/5406a663-c73f-4a2b-9b75-e54bd8f74b90";
    fsType = "btrfs";
    options = [ "subvol=@nix" "compress=zstd" "noatime" ];
  };

  fileSystems."/persist" = {
    device = "/dev/disk/by-uuid/5406a663-c73f-4a2b-9b75-e54bd8f74b90";
    fsType = "btrfs";
    options = [ "subvol=@persist" "compress=zstd" "noatime" ];
    neededForBoot = true;
  };

  fileSystems."/var/log" = {
    device = "/dev/disk/by-uuid/5406a663-c73f-4a2b-9b75-e54bd8f74b90";
    fsType = "btrfs";
    options = [ "subvol=@log" "compress=zstd" "noatime" ];
    neededForBoot = true;
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/35DB-E5F8";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=0022" ];
  };

  # -----------------------
  # Memory
  # -----------------------
  swapDevices = [ { device = "/swapfile"; size = 4*1024;} ];

  # -----------------------
  # Network
  # -----------------------
  networking.useDHCP = lib.mkDefault true;
  networking.hostName = "mimir";
  networking.networkmanager.enable = true;
  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;
  systemd.services.NetworkManager-wait-online.enable = false;


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
  services.thinkfan.enable = true;
  services.thermald.enable = true;
  services.thinkfan.levels = [
  [
    0
    0
    55
  ]
  [
    1
    48
    60
  ]
  [
    2
    50
    61
  ]
  [
    3
    52
    63
  ]
  [
    6
    56
    65
  ]
  [
    7
    60
    75
  ]
  [
    "level full-speed"
    70
    32767
  ]

  ];
  # -----------------------
  # GPU Support
  # -----------------------
  # Environment Variables
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "i965";
    NIXOS_OZONE_WL = "1";
    RUSTICL_ENABLE = "iris";
  };

  # Video acceleration
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };

  # OpenGL and Others
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      libvdpau-va-gl # Video acceleration
      intel-compute-runtime # OpenCL
      mesa.opencl
    ];
  };

  # -----------------------
  # CPU Emulation
  # -----------------------
  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
    "riscv64-linux"
  ];

  # VPN
  services.tailscale.extraSetFlags = [
    "--accept-routes"
  ];

  # Fingerprint
  services."06cb-009a-fingerprint-sensor" = {
    enable = true;
    backend = "python-validity";
  };
}
