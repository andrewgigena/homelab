{ pkgs, ... }:

{
  services = {
    xserver.enable = true;
    desktopManager.plasma6.enable = true;
    displayManager = {
      sddm.enable = true;
      sddm.wayland.enable = true;
      sddm.autoLogin.relogin = true; # Login not needed due to using Full Disk Encryption on boots and on hibernation.
      defaultSession = "plasma";
      autoLogin.enable = true; # Login not needed due to using Full Disk Encryption on boots and on hibernation.
      autoLogin.user = "shadows";
    };
  };
}
