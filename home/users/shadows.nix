{ pkgs, ... }:

{
  home.username = "shadows";
  home.homeDirectory = "/home/shadows";
  home.stateVersion = "24.05";
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;
  systemd.user.startServices = "sd-switch";

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.git.enable = true;
  programs.git.userEmail = "mail@andrewgigena.dev";
  programs.git.userName = "Andrew Gigena";
  programs.neovim.enable = true;
  programs.command-not-found.enable = true;
  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.autosuggestion.enable = true;
  programs.zsh.syntaxHighlighting.enable = true;
  programs.zsh.zsh-abbr.enable = true;
  programs.zsh.shellAliases.nixos = "sudo nixos-rebuild --flake /etc/nixos/#$(hostname)";
  programs.zsh.oh-my-zsh.enable = true;
  programs.zsh.oh-my-zsh.plugins = [ "git" "sudo" ];
  programs.zsh.oh-my-zsh.theme = "agnoster";
}
