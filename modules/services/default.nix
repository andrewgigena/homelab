{ ... }:

{
  imports = [
    ./audio.nix
    ./network.nix
    ./syncthing.nix
    ./virtualisation.nix
  ];

  services = {
    fstrim.enable = true;
    printing.enable = true;
    libinput.enable = true;
    openssh.enable = true;
    flatpak.enable = true;
  };

  programs.kdeconnect.enable = true;
}
