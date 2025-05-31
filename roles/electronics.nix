{ pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs-unstable; [
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
