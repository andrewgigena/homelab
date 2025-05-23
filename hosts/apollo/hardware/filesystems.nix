{ pkgs, ... }:

{
  # Disks and partitions
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/7940e481-14e5-4f5c-8df4-793d4c77c832";
      fsType = "btrfs";
      options = [
        "subvol=@root"
        "compress=zstd"
        "noatime"
      ];
    };
    "/home" = {
      device = "/dev/disk/by-uuid/7940e481-14e5-4f5c-8df4-793d4c77c832";
      fsType = "btrfs";
      options = [
        "subvol=@home"
        "compress=zstd"
        "noatime"
      ];
    };
    "/nix" = {
      device = "/dev/disk/by-uuid/7940e481-14e5-4f5c-8df4-793d4c77c832";
      fsType = "btrfs";
      options = [
        "subvol=@nix"
        "compress=zstd"
        "noatime"
      ];
    };
    "/persist" = {
      device = "/dev/disk/by-uuid/7940e481-14e5-4f5c-8df4-793d4c77c832";
      fsType = "btrfs";
      options = [
        "subvol=@persist"
        "compress=zstd"
        "noatime"
      ];
    };
    "/var/log" = {
      device = "/dev/disk/by-uuid/7940e481-14e5-4f5c-8df4-793d4c77c832";
      fsType = "btrfs";
      options = [
        "subvol=@log"
        "compress=zstd"
        "noatime"
      ];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/055C-B0AB";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };
    "/disks/secondary" = {
      device = "/dev/disk/by-uuid/f6b3125d-3bb2-4233-a166-53e421220369";
      fsType = "btrfs";
      options = [
        "compress=zstd"
        "noatime"
      ];
    };
  };

  # Swap
  swapDevices = [
    {
      device = "/swapfile";
      size = 4 * 1024;
    }
  ];
}
