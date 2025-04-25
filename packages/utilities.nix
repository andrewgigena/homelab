{ pkgs, pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs; [
    anydesk     # Desktop sharing and remote support
    bitwarden   # Password manager
    helvum      # Pipewire manager
    obsidian    # Notes
    yakuake     # Dropdown Terminal
    typst       # Markup-based typesetting system
    onlyoffice-desktopeditors
  ];
}
