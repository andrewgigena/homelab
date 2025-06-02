{ pkgs, pkgs-unstable, ... }:
let
  systemdgenie-latest = (
    pkgs-unstable.systemdgenie.overrideAttrs (old: {
      version = "0.100.0";
      src = pkgs-unstable.fetchFromGitLab {
        domain = "invent.kde.org";
        repo = "SystemdGenie";
        owner = "system";
        rev = "751895865258f42add95caba08a89eb1819f12c6";
        hash = "sha256-NAVhurcRqEIKMtn7/NBsiXQbE44RYreCJf4ESi8KSoI=";
      };
      nativeBuildInputs = [
        pkgs-unstable.cmake
        pkgs-unstable.kdePackages.extra-cmake-modules
        pkgs-unstable.kdePackages.wrapQtAppsHook
        pkgs-unstable.pkg-config
      ];
      buildInputs = [
        pkgs-unstable.kdePackages.kxmlgui
        pkgs-unstable.kdePackages.kauth
        pkgs-unstable.kdePackages.kcrash
        pkgs-unstable.kdePackages.ktexteditor
        pkgs-unstable.kdePackages.kio
        pkgs-unstable.pipewire
        pkgs-unstable.kdePackages.kirigami-addons
      ];
    })
  );

  kdePackages = with pkgs.kdePackages; [
    krdc
    krfb
    kompare
    ksystemlog
    kjournald
    kalk
    yakuake # Dropdown Terminal
  ];

  internetPackages = with pkgs-unstable; [
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

  utilitiesPackages = with pkgs-unstable; [
    anydesk # Desktop sharing and remote support
    bitwarden # Password manager
    helvum # Pipewire manager
  ];

  officePackages = with pkgs-unstable; [
    obsidian # Notes
    typst # Markup-based typesetting system
    onlyoffice-desktopeditors # Office suite
    anki-bin # Flashcard program
    poppler_utils # PDF utilities
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

  # Plasma Autologin (Login not needed due to using FDE on boots and on hibernation.)
  services.displayManager = {
    autoLogin.enable = true;
    autoLogin.user = "shadows";
    sddm.autoLogin.relogin = true;
  };

  # Enable extra apps
  programs.partition-manager.enable = true;
  programs.kdeconnect.enable = true;
  programs.wireshark.enable = true;

  # Enable Flatpak support
  services.flatpak.enable = true;

  # Install packages
  environment.systemPackages =
    kdePackages ++ internetPackages ++ utilitiesPackages ++ officePackages ++ multimediaPackages;
}
