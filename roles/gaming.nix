{ pkgs-unstable, ... }:

{
  programs = {
    steam.enable = true;
    steam.gamescopeSession.enable = true;
    gamemode.enable = true;
  };

  environment.systemPackages = with pkgs-unstable; [
    cemu
    lutris
  ];
}
