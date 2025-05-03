{ pkgs, pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox           # Web Browser
    google-chrome    # Web Browser
    tor-browser      # Web Browser
    qbittorrent     # Torrents
    telegram-desktop # Instant Messaging
    thunderbird      # Email manager
    element-desktop
    #rustdesk
    discord
  ];
}
