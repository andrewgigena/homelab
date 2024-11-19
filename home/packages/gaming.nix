{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cemu      # Nintendo Wii U Emulator
    lutris
  ];
}
