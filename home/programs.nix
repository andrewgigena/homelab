{ ... }:

{
  programs = {
    git.enable = true;
    neovim.enable = true;
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        nixos = "sudo nixos-rebuild --flake /etc/nixos/#$(hostname)";
      };

      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "agnoster";
      };
    };
  };
}
