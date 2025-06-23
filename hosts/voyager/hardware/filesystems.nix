{ ... }:

{
  # Disks and partitions
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/9dc6379d-f8d5-41cd-ad6d-8d0687346f32";
      fsType = "btrfs";
      options = [
        "subvol=@root"
        "compress=zstd"
        "noatime"
      ];
    };

    "/home" = {
      device = "/dev/disk/by-uuid/9dc6379d-f8d5-41cd-ad6d-8d0687346f32";
      fsType = "btrfs";
      options = [
        "subvol=@home"
        "compress=zstd"
        "noatime"
      ];
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/9dc6379d-f8d5-41cd-ad6d-8d0687346f32";
      fsType = "btrfs";
      options = [
        "subvol=@nix"
        "compress=zstd"
        "noatime"
      ];
    };

    "/persist" = {
      device = "/dev/disk/by-uuid/9dc6379d-f8d5-41cd-ad6d-8d0687346f32";
      fsType = "btrfs";
      options = [
        "subvol=@persist"
        "compress=zstd"
        "noatime"
      ];
      neededForBoot = true;
    };

    "/var/log" = {
      device = "/dev/disk/by-uuid/9dc6379d-f8d5-41cd-ad6d-8d0687346f32";
      fsType = "btrfs";
      options = [
        "subvol=@log"
        "compress=zstd"
        "noatime"
      ];
      neededForBoot = true;
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/632D-6D3C";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };
  };

  swapDevices = [
    {
      device = "/swapfile";
      size = 4 * 1024;
    }
  ];
}
