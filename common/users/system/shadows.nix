{ pkgs, pkgs-unstable, ... }:

{
  programs.fish.enable = true;
  programs.fish.shellAliases.nixos = "sudo nixos-rebuild --flake /etc/nixos/#$(hostname)";
  users.defaultUserShell = pkgs-unstable.fish;
  users.extraUsers  = {
    shadows = {
      description = "Andrew Gigena";
      extraGroups = [ "wheel" "adbusers" "plugdev" "docker" ];
      home = "/home/shadows";
      initialHashedPassword = "$y$j9T$r9kBULYu9npZRW/i3V9vF/$g7FqafE1uv205.opfOe0.Sq/ma7WaoXcAW3FHGxUsI7";
      isNormalUser = true;
      linger = true;
      uid = 1000;
      useDefaultShell = true;
    };
  };
}
