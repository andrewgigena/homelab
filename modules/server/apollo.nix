{ pkgs, ... }:

{
  services.syncthing = {
    enable = true;
    user = "shadows";
    dataDir = "/disks/nas/data/syncthing";
    configDir = "/disks/nas/configs/syncthing";
  };

  virtualisation.docker.enable = true;
  virtualisation.oci-containers.backend = "docker";
  virtualisation.oci-containers.containers = {
    nginx-proxy-manager = {
      image = "jc21/nginx-proxy-manager:latest";
      autoStart = true;
      ports = [
        "80:80"
        "81:81"
        "443:443"
      ];
      volumes = [
        "/disks/nas/configs/nginx/data:/data"
        "/disks/nas/configs/nginx/letsencrypt:/etc/letsencrypt"
      ];

      extraOptions = [
        "--network=apollo"
      ];
    };

    pihole = {
      image = "pihole/pihole:latest";
      autoStart = true;

      ports = [
        "53:53/tcp"
        "53:53/udp"
        "67:67/udp"
        "8000:80/tcp"
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
        "--network=apollo"
      ];
    };

    ddns-updater = {
      image = "qmcgaw/ddns-updater";
      autoStart = true; 

      ports = [
        "9249:8000/tcp"
      ];

      volumes = [
        "/disks/nas/configs/ddns-updater:/updater/data"
      ];


      extraOptions = [
        "--network=apollo"
      ];
    };

    owntracks-recorder = {
      image = "owntracks/recorder";
      ports = [
        "8083:8083"
      ];
      environment = {
        OTR_PORT = "0"; # Disable MQTT by setting the environment variable.
      };
      volumes = [
        "/disks/nas/configs/owntracks:/config"
        "/disks/nas/data/owntracks:/store"
      ];
      autoStart = true;
      extraOptions = [
      	"--name=owntracks-recorder"
	"--network=apollo"
      ];
    };
  };

  systemd.services."docker-network-apollo" = {
    description = "Create Docker Network Apollo";
    serviceConfig.Type = "oneshot";
    wantedBy = [ "multi-user.target" ];
    script = ''
      ${pkgs.docker}/bin/docker network inspect apollo > /dev/null 2>&1 || \
      ${pkgs.docker}/bin/docker network create apollo --subnet 172.20.0.0/16
    '';
  };
}
