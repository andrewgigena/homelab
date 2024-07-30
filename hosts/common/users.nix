{ pkgs, ... }:
{
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  users.users.shadows = {
    useDefaultShell = true;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPassword = null;
  };
}
