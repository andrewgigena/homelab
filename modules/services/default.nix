{ ... }:

{
  imports = [
    ./syncthing.nix
    ./virtualisation.nix
  ];

  services = {
    fstrim.enable = true;
    printing.enable = true;
    libinput.enable = true;
    openssh.enable = true;
    flatpak.enable = true;

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };

    avahi = {
      enable = true;
      nssmdns4 = true;
      publish = {
        enable = true;
        addresses = true;
        domain = true;
        hinfo = true;
        userServices = true;
        workstation = true;
      };
    };
  };

  programs.kdeconnect.enable = true;
}
