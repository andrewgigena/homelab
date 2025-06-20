{ pkgs, ... }:

{
  programs = {
    steam.enable = true;
    steam.gamescopeSession.enable = true;
    gamemode.enable = true;
  };

  environment.systemPackages = with pkgs; [
    cemu
    lutris
  ];
}
