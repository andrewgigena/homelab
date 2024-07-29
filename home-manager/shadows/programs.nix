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
        nixos-mimir  = "sudo nixos-rebuild --flake /etc/nixos/#mimir";
        nixos-kepler = "sudo nixos-rebuild --flake /etc/nixos/#kepler";
      };

      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "agnoster";
      };
    };
  };
}
