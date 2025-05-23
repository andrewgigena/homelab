{ pkgs, ... }:
{
  services.tailscale.extraSetFlags = [
    "--accept-routes"
  ];

  services.udev.extraRules = builtins.readFile ../../extra/udev_rules/69-probe-rs.rules;

  systemd.user.services.disable-auto-mute = {
    enable = true;
    description = "Disable auto-mute so speakers can work with headphones plugged in";
    after = [
      "graphical-session-pre.target"
      "pipewire.service"
    ];
    partOf = [
      "graphical-session.target"
      "pipewire.service"
    ];
    wantedBy = [ "graphical-session.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.bash}/bin/bash -c 'for device in $(${pkgs.alsa-utils}/bin/aplay -L | grep -oP \"^[^\\s]*\"); do ${pkgs.alsa-utils}/bin/amixer -D \"$device\" sset \"Auto-Mute Mode\" Disabled 2>/dev/null || true; done'";
      Type = "oneshot";
    };
  };

  # For syncing files across devices
  services.syncthing = {
    enable = true;
    user = "shadows";
    dataDir = "/home/shadows/Syncthing";
    configDir = "/home/shadows/.local/state/syncthing/";
  };
}
