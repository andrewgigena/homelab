{ lib, pkgs, ... }:
{
  imports = [
    ./bootloader.nix
    ./filesystems.nix
    ./firmware.nix
    ./gpu.nix
    ./power_management.nix
  ];
}
