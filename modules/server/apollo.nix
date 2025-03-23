{ pkgs, lib, ... }:

{
  # -----------------------
  # VPN Network
  # -----------------------
  services.tailscale.extraSetFlags = [
    "--advertise-routes=192.168.1.0/24,192.168.2.0/24"
    "--accept-dns=false"
  ];

  # -----------------------
  # Homepage for VPN Network
  # -----------------------
  services.homepage-dashboard = {
    enable = true;
    openFirewall = true;
    bookmarks = [
        {
          "Herramientas de IA" = [
            { "ChatGPT" = [{ icon = "chatgpt.svg"; href = "https://chatgpt.com/"; }]; }
            { "Deepseek" = [{ icon = "deepseek.svg"; href = "https://chat.deepseek.com/"; }]; }
            { "Claude" = [{ icon = "claude-ai.svg"; href = "https://claude.ai/new"; }]; }
            { "Perplexity" = [{ icon = "perplexity-book-dark.svg"; href = "https://perplexity.ai/"; }]; }
            { "Huggingface Chat" = [{ icon = "hugging-face.svg"; href = "https://huggingface.co/chat"; }]; }
          ];
        }
        {
          "Redes Sociales & Multimedia" = [
            { "Reddit" = [{ icon = "reddit.svg"; href = "https://www.reddit.com/"; }]; }
            { "Netflix" = [{ icon = "netflix.svg"; href = "https://netflix.com/"; }]; }
            { "MyAnimeList" = [{ abbr = "MAL"; href = "https://myanimelist.net/"; }]; }
            { "HiAnime" = [{ abbr = "HA"; href = "https://hianime.to/"; }]; }
          ];
        }
        {
          "Productividad" = [
            { "GitHub" = [{ icon = "github.svg"; href = "https://github.com/"; }]; }
            { "Whatsapp Web" = [{ icon = "whatsapp.svg"; href = "https://web.whatsapp.com/"; }]; }
            { "Excalidraw" = [{ icon = "excalidraw.svg"; href = "https://excalidraw.com/"; }]; }
            { "Google Drive" = [{ icon = "google-drive.svg"; href = "https://drive.google.com/"; }]; }
            { "Google Gmail" = [{ icon = "gmail.svg"; href = "https://mail.google.com/"; }]; }
            { "Google Calendar" = [{ icon = "google-calendar.svg"; href = "https://calendar.google.com/"; }]; }
          ];
        }
      ];
    widgets = [
      {
        search = {
          provider = "google";
          focus = "true";
          showSearchSuggestions = "true";
          target = "_blank";
        };
      }
      {
        greeting = {
          text_size = "xl";
          text = "Bienvenido de vuelta a casa";
        };
      }
      {
        openmeteo = {
          label = "Montevideo";
          latitude = "34.8798";
          longitude = "56.1755";
          timezone = "America/Montevideo";
          units = "metric";
          cache = "5";
        };
      }
    ];
    services = [
      {
        "Multimedia" = [
          { "Jellyfin" = { icon = "jellyfin.svg"; description = "Plataforma para ver tus series y películas en casa"; href = "http://jellyfin.andrewgigena.dev/"; }; }
          { "Sonarr" = { icon = "sonarr.svg"; description = "Organiza y descarga series de TV automáticamente"; href = "http://sonarr.andrewgigena.dev/"; }; }
          { "Radarr" = { icon = "radarr.svg"; description = "Organiza y descarga películas automáticamente"; href = "http://radarr.andrewgigena.dev/"; }; }
          { "Lidarr" = { icon = "lidarr.svg"; description = "Organiza y descarga música automáticamente"; href = "http://lidarr.andrewgigena.dev/"; }; }
          { "Readarr" = { icon = "readarr.svg"; description = "Organiza y descarga libros & audiolibros automáticamente"; href = "http://readarr.andrewgigena.dev/"; }; }
        ];
      }
      {
        "Gestión de Servidores" = [
          { "Nginx Proxy Manager" = { icon = "nginx-proxy-manager.svg"; description = "Gestor de accesos y seguridad para servidores"; href = "http://nginx.andrewgigena.dev/"; }; }
          { "Pihole" = { icon = "pi-hole.svg"; description = "Bloqueador de anuncios para toda tu red"; href = "http://pihole.andrewgigena.dev/"; }; }
          { "Homepage Dashboard" = { icon = "homepage.png"; description = "Panel centralizado para gestionar y visualizar tus servicios"; href = "http://home.andrewgigena.dev/"; }; }
          { "qBittorrent" = { icon = "qbittorrent.svg"; description = "Cliente para descargar y gestionar torrents"; href = "http://qbittorrent.andrewgigena.dev/"; }; }
        ];
      }
      {
        "Automatización y Sincronización" = [
          { "Bazarr" = { icon = "bazarr.svg"; description = "Automatiza la descarga y gestión de subtítulos"; href = "http://bazarr.andrewgigena.dev/"; }; }
          { "Prowlarr" = { icon = "prowlarr.svg"; description = "Administra indexadores para búsquedas de contenido"; href = "http://prowlarr.andrewgigena.dev/"; }; }
          { "Syncthing (apollo)" = { icon = "syncthing.svg"; description = "Sincronización de archivos entre dispositivos"; href = "http://syncthing.andrewgigena.dev/"; }; }
        ];
      }
      {
        "Monitoreo" = [
          { "Frigate" = { icon = "frigate.svg"; description = "Sistema de videovigilancia con detección inteligente"; href = "http://frigate.andrewgigena.dev/"; }; }
          { "OwnTracks" = { icon = "owntracks.svg"; description = "Aplicación para compartir y rastrear ubicaciones"; href = "http://owntracks-ui.andrewgigena.dev/"; }; }
        ];
      }
    ];
  };

  # -----------------------
  # Priting Support
  # -----------------------
  services = {
    printing.enable = true;
    printing.drivers = [ pkgs.brlaser ]; # Brother support
    printing.listenAddresses = [ "*:631" ];
    printing.allowFrom = [ "all" ];
    printing.browsing = true;
    printing.defaultShared = true;
    printing.openFirewall = true;
    avahi.enable = true;
    avahi.publish.enable = true;
    avahi.publish.userServices = true;
  };

  # -----------------------
  # Local services: qBittorrent
  # -----------------------
  environment.systemPackages = with pkgs; [
    qbittorrent-nox # Download manager
  ];

  systemd.services."qbittorrent-webui" = {
    description = "Starts qBittorrent webui";
    serviceConfig.Type = "oneshot";
    wantedBy = [ "multi-user.target" ];
    script = ''
      ${pkgs.qbittorrent-nox}/bin/qbittorrent-nox
    '';
  };

  # -----------------------
  # Local services: Syncthing
  # -----------------------
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    guiAddress = "0.0.0.0:8384";
    user = "shadows";
    dataDir = "/disks/nas/data/syncthing";
    configDir = "/disks/nas/configs/syncthing";
  };

  # -----------------------
  # Local services: Multimedia
  # -----------------------
  services.sonarr.enable = true;
  services.readarr.enable = true;
  services.radarr.enable = true;
  services.prowlarr.enable = true;
  services.lidarr.enable = true;
  services.bazarr.enable = true;
  services.jellyfin.enable = true;

  # -----------------------
  # Docker-based services
  # -----------------------
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
        "--network=host"
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

    # ddns-updater = {
    #   image = "qmcgaw/ddns-updater";
    #   autoStart = true;

    #   ports = [
    #     "9249:8000/tcp"
    #   ];

    #   volumes = [
    #     "/disks/nas/configs/ddns-updater:/updater/data"
    #   ];


    #   extraOptions = [
    #     "--network=apollo"
    #   ];
    # };

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

    owntracks-ui = {
      image = "owntracks/frontend";
      ports = [
        "8084:80"
      ];
      environment = {
        SERVER_HOST = "owntracks-recorder.apollo";
        SERVER_PORT = "8083";
      };
      autoStart = true;
      extraOptions = [
       "--name=owntracks-ui"
       "--network=apollo"
      ];
    };

    mariela-strapi = {
      image = "vshadbolt/strapi";
      autoStart = true;
      ports = [ "1337:1337" ];
      volumes = [ "/disks/nas/data/mariela-strapi/backend:/srv/app" ];
      extraOptions = [
        "--name=mariela-strapi"
        "--network=apollo"
      ];
    };

    frigate = {
      image = "ghcr.io/blakeblackshear/frigate:stable-rocm";
      autoStart = true;
      ports = [
        "8971:8971"
        "8554:8554"
        "8555:8555/tcp"
        "8555:8555/udp"
      ];
      volumes = [
        "/disks/nas/data/frigate:/media/frigate"
        "/disks/nas/configs/frigate:/config"
        "/etc/localtime:/etc/localtime:ro"
      ];
      environment = {
        FRIGATE_RTSP_PASSWORD = "password"; # useless
      };
      extraOptions = [
        # Device passthrough
        "--device=/dev/kfd"
        "--device=/dev/dri"

        # Shared memory
        "--shm-size=1G"

        # Network and stop configuration
        "--network=apollo"
        "--stop-timeout=30"
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
