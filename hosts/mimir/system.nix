{ pkgs, ... }:
{
  # VPN
  services.tailscale.extraSetFlags = [
    "--accept-routes"
  ];

  # For syncing files across devices
  services.syncthing = {
    enable = true;
    user = "shadows";
    dataDir = "/home/shadows/Syncthing";
    configDir = "/home/shadows/.local/state/syncthing/";
  };
}
