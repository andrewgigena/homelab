{ pkgs, pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs; [
    lutris
  ];
}
