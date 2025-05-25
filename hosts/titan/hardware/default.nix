{ lib, pkgs, ... }:
{
  imports = [
    ./bootloader.nix
    ./filesystems.nix
    ./firmware.nix
    ./power_management.nix
  ];
}
