{ pkgs, ... }:

{
  # Disks and partitions
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/8bbf763e-0613-48b6-8ed0-d15a83510946";
      fsType = "btrfs";
      options = [
        "subvol=@root"
        "compress=zstd"
        "noatime"
      ];
    };

    "/home" = {
      device = "/dev/disk/by-uuid/8bbf763e-0613-48b6-8ed0-d15a83510946";
      fsType = "btrfs";
      options = [
        "subvol=@home"
        "compress=zstd"
        "noatime"
      ];
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/8bbf763e-0613-48b6-8ed0-d15a83510946";
      fsType = "btrfs";
      options = [
        "subvol=@nix"
        "compress=zstd"
        "noatime"
      ];
    };

    "/persist" = {
      device = "/dev/disk/by-uuid/8bbf763e-0613-48b6-8ed0-d15a83510946";
      fsType = "btrfs";
      options = [
        "subvol=@persist"
        "compress=zstd"
        "noatime"
      ];
      neededForBoot = true;
    };

    "/var/log" = {
      device = "/dev/disk/by-uuid/8bbf763e-0613-48b6-8ed0-d15a83510946";
      fsType = "btrfs";
      options = [
        "subvol=@log"
        "compress=zstd"
        "noatime"
      ];
      neededForBoot = true;
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/A901-69EC";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };

    # - Frodo - Samsung SSD 860 EVO 500GB
    "/disks/frodo" = {
      device = "/dev/disk/by-uuid/ee9b5975-4368-4960-bcbb-1a30bff4208d";
      fsType = "btrfs";
      options = [
        "compress=zstd"
        "noatime"
        "nofail"
        "x-systemd.device-timeout=5"
      ];
    };

    # - Gandalf - FUJITSU MJA2320BH G2
    "/disks/gandalf" = {
      device = "/dev/disk/by-uuid/75009ea3-cb1f-4cc0-ac88-e403e44e232a";
      fsType = "btrfs";
      options = [
        "compress=zstd"
        "noatime"
        "nofail"
        "x-systemd.device-timeout=5"
      ];
    };

    # - PostmarketOS - WDC WD10JPVX-60JC3T0
    "/disks/postmarketos" = {
      device = "/dev/disk/by-uuid/0090e30f-007a-45ea-a23f-6868a371a41d";
      fsType = "ext4";
      options = [
        "defaults"
        "noatime"
        "nofail"
        "async"
        "x-systemd.device-timeout=5"
      ];
    };
  };
}
