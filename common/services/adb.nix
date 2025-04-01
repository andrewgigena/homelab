{ pkgs, ... }:

{
  services.udev.packages = [ pkgs.android-udev-rules ];
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="2e04", MODE="0660", GROUP="adbusers", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTR{idVendor}=="2e04", ATTR{idProduct}=="c009", SYMLINK+="android_adb"
    SUBSYSTEM=="usb", ATTR{idVendor}=="2e04", ATTR{idProduct}=="c009", SYMLINK+="android_fastboot"
  '';
  programs.adb.enable = true;
}
