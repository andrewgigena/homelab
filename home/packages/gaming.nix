{ pkgs, pkgs-unstable, ... }:

{
  home.packages = with pkgs; [
    cemu      # Nintendo Wii U Emulator
    lutris
  ];
}
