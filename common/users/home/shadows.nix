{ ... }:

{
  home.username = "shadows";
  home.homeDirectory = "/home/shadows";
  home.stateVersion = "24.05";
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;
  systemd.user.startServices = "sd-switch";
  programs.git.enable = true;
  programs.git.userEmail = "mail@andrewgigena.dev";
  programs.git.userName = "Andrew Gigena";
  services.ssh-agent.enable = true;
  home.sessionPath = [
    "/home/shadows/.cargo/bin"
  ];
}
