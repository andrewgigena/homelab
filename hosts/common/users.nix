{ inputs, outputs, pkgs, ... }:

{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
      extraSpecialArgs = { inherit inputs outputs; };
      users = {
          shadows = import ../../home;
      };
  };
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  users.users.shadows = {
    useDefaultShell = true;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPassword = null;
  };
}
