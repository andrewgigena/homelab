{ pkgs, pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs; [
    pulseview
    wireshark
    tshark
    arduino-ide
    minicom
    fritzing
    kicad
    freecad-qt6
  ];
}
