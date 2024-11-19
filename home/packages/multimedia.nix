{ pkgs, pkgs-unstable, ... }:

{
  home.packages = with pkgs; [
    audacity                                    # Audio editor
    ffmpeg                                      # The ultimate media tool
    gimp                                        # Image editor
    imagemagick                                 # Image conversor
    inkscape                                    # Vectors image editor
    kdePackages.kdeconnect-kde                 # Remote access to computer from my phone
    mediainfo                                   # Info about audio/video/subtitle
    mpv                                         # Video reproductor
    obs-studio                                  # Audio/Video recoder
    vlc                                         # Video reproductor
    yt-dlp                                      # Download videos from YouTube
    spotify
  ];
}
