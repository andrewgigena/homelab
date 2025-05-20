{ pkgs, pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs; [
    anydesk     # Desktop sharing and remote support
    bitwarden   # Password manager
    helvum      # Pipewire manager
    yakuake     # Dropdown Terminal
  ];
}
