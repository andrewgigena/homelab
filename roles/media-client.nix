{ pkgs, pkgs-unstable, ... }:
let
  kdePackages = with pkgs.kdePackages; [
    krdc
    krfb
    kompare
    ksystemlog
    kjournald
    kalk
    yakuake # Dropdown Terminal
  ];

  utilitiesPackages = with pkgs-unstable; [
    easyeffects
  ];

  multimediaPackages = with pkgs-unstable; [
    ffmpeg # The ultimate media tool
    imagemagick # Image conversor
    mediainfo # Info about audio/video/subtitle
    mpv # Video reproductor
    vlc # Video reproductor
    yt-dlp # Download videos from YouTube
    spotify
    jellyfin-media-player
  ];

in
{
  # Installs KDE Plasma 6
  services = {
    xserver.enable = true;
    desktopManager.plasma6.enable = true;
    displayManager = {
      sddm.enable = true;
      sddm.wayland.enable = true;
      defaultSession = "plasma";
    };
  };

  # Plasma Autologin
  services.displayManager = {
    autoLogin.enable = true;
    autoLogin.user = "shadows";
    sddm.autoLogin.relogin = true;
  };

  # Enable extra apps
  programs.partition-manager.enable = true;
  programs.kdeconnect.enable = true;

  # Install packages
  environment.systemPackages =
    kdePackages ++ utilitiesPackages ++ multimediaPackages;
}
