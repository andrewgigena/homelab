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
  programs.partition-manager.enable = true;
  environment.systemPackages = with pkgs; [
    kdePackages.kdeconnect-kde # Remote access to computer from my phone
    kdePackages.krdc
    kdePackages.krfb
    kdePackages.kompare
    kdePackages.ksystemlog
    kdePackages.kjournald
    kdePackages.kalk
    systemdgenie
  ];
}
