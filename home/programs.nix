{ ... }:

{
  programs = {
    git = {
      enable = true;
      userEmail = "mail@andrewgigena.dev";
      userName = "Andrew Gigena";
    };
    neovim.enable = true;
    command-not-found.enable = true;
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      zsh-abbr.enable = true;

      shellAliases = {
        nixos = "sudo nixos-rebuild --flake /etc/nixos/#$(hostname)";
      };

      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "sudo"];
        theme = "agnoster";
      };
    };
  };
}
