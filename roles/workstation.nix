{ pkgs, ... }:
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

  internetPackages = with pkgs; [
    firefox # Web Browser
    google-chrome # Web Browser
    tor-browser # Web Browser
    qbittorrent # Torrents
    telegram-desktop # Instant Messaging
    thunderbird # Email manager
    element-desktop
    #rustdesk
    discord
    zoom-us
  ];

  utilitiesPackages = with pkgs; [
    anydesk # Desktop sharing and remote support
    bitwarden # Password manager
    helvum # Pipewire manager
    easyeffects
    # appimage-run
  ];

  officePackages = with pkgs; [
    obsidian # Notes
    typst # Markup-based typesetting system
    onlyoffice-desktopeditors # Office suite
    anki-bin # Flashcard program
    poppler_utils # PDF utilities
  ];

  multimediaPackages = with pkgs; [
    ffmpeg # The ultimate media tool
    imagemagick # Image conversor
    mediainfo # Info about audio/video/subtitle
    mpv # Video reproductor
    vlc # Video reproductor
    yt-dlp # Download videos from YouTube
    spotify
    jellyfin-media-player
  ];

  winePackagesC = with pkgs; [
    wineWowPackages.waylandFull
    winetricks
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

      # Plasma Autologin (Login not needed due to using FDE on boots and on hibernation.)
      sddm.autoLogin.relogin = true;
      autoLogin.enable = true;
      autoLogin.user = "shadows";
    };
    colord.enable = true;
  };

  # Enable extra apps
  programs.partition-manager.enable = true;
  programs.kdeconnect.enable = true;
  programs.wireshark.enable = true;

  # Enable Flatpak support
  services.flatpak.enable = true;

  # Install packages
  environment.systemPackages =
    kdePackages
    ++ internetPackages
    ++ utilitiesPackages
    ++ officePackages
    ++ multimediaPackages
    ++ winePackagesC;
}
