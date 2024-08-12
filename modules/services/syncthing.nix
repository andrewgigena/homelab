{ ... }:

{
  services.syncthing = {
    enable = true;
    user = "shadows";
    dataDir = "/home/shadows/Syncthing";
    configDir = "/home/shadows/.local/state/syncthing/";
  };
}
