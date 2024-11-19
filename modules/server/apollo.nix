{ pkgs, ... }:

{
  services.syncthing = {
    enable = true;
    user = "shadows";
    dataDir = "/disks/nas/configs/syncthing";
    configDir = "/disks/nas/configs/syncthing";
  };

  environment.systemPackages = [
    pkgs.owntracks-recorder
  ];

  virtualisation.docker.enable = true;
  virtualisation.oci-containers.backend = "docker";
  virtualisation.oci-containers.containers = {
    nginx-proxy-manager = {
      image = "jc21/nginx-proxy-manager:latest";
      autoStart = true;
      ports = [
        "8080:80"
        "8081:81"
        "8443:443"
      ];
      volumes = [
        "/disks/nas/configs/nginx/data:/data"
        "/disks/nas/configs/nginx/letsencrypt:/etc/letsencrypt"
      ];
    };
    pihole = {
      image = "pihole/pihole:latest";
      autoStart = true;

      ports = [
        "53:53/tcp"
        "53:53/udp"
        "67:67/udp"
        "80:80/tcp"
      ];

      volumes = [
        "/disks/nas/configs/pihole/pihole/:/etc/pihole"
        "/disks/nas/configs/pihole/dnsmasq/:/etc/dnsmasq.d"
      ];

      environment = {
        TZ = "America/Chicago";
        DNSMASQ_LISTENING = "all";
      };

      extraOptions = [
        "--cap-add=NET_ADMIN"
        "--network=bridge"
      ];
    };
    ddns-updater = {
      image = "qmcgaw/ddns-updater";
      autoStart = true; 

      ports = [
        "9249:8000/tcp"
      ];

      volumes = [
        "/disks/nas/configs/ddns-updater/config.json:/updater/data/config.json"
      ];

      extraOptions = [
        "--network=bridge"
      ];
    };
  };
}
