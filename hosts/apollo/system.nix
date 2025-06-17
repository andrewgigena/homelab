{ pkgs, config, ... }:
{
  services.samba = {
    enable = true;
    openFirewall = true;
    nsswins = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = config.networking.hostName;
        "netbios name" = config.networking.hostName;
        "security" = "user";
        "guest account" = "nobody";
        "map to guest" = "bad user";
      };
    };
  };
  # make shares visible for windows 10 clients
  services.samba-wsdd = {
    enable = true;
    workgroup = "WORKGROUP";
    openFirewall = true;
    hostname = config.networking.hostName;
  };

  # Brother printer sharing
  services = {
    printing.enable = true;
    printing.drivers = [ pkgs.brlaser ];
    printing.listenAddresses = [ "*:631" ];
    printing.allowFrom = [ "all" ];
    printing.browsing = true;
    printing.defaultShared = true;
    printing.openFirewall = true;
    printing.snmpConf = ''
      Address @LOCAL
      Address 100.100.1.0/24
    '';
    avahi.enable = true;
    avahi.publish.enable = true;
    avahi.publish.userServices = true;
    avahi.publish.addresses = true;
  };

  services.tailscale.extraSetFlags = [
    "--accept-routes"
  ];

}
