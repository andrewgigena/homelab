{ lib, pkgs, ... }:
{
  imports = [
    ./bootloader.nix
    ./display.nix
    ./filesystems.nix
    ./firmware.nix
    ./gpu.nix
    ./power_management.nix
  ];
}
