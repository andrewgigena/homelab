{ ... }:

{
  boot.supportedFilesystems = [ "btrfs" ];
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd.systemd.enable = true;
    plymouth.enable = true;
    kernelParams = [ "quiet" "splash" "udev.log_level=0" ];
    extraModprobeConfig = "";
  };
}
