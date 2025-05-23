{ pkgs, pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs; [
    pulseview
    wireshark
    tshark
    arduino-ide
  ];
}
