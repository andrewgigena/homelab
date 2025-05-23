{ config, pkgs, ... }:

{
  # Cloudflare for exposed services
  services.cloudflared.enable = true;

  # Homepage for VPN Network
  services.homepage-dashboard = {
    enable = true;
    openFirewall = true;
    bookmarks = [
      {
        "Herramientas de IA" = [
          {
            "ChatGPT" = [
              {
                icon = "chatgpt.svg";
                href = "https://chatgpt.com/";
              }
            ];
          }
          {
            "Deepseek" = [
              {
                icon = "deepseek.svg";
                href = "https://chat.deepseek.com/";
              }
            ];
          }
          {
            "Claude" = [
              {
                icon = "claude-ai.svg";
                href = "https://claude.ai/new";
              }
            ];
          }
          {
            "Perplexity" = [
              {
                icon = "perplexity-book-dark.svg";
                href = "https://perplexity.ai/";
              }
            ];
          }
          {
            "Huggingface Chat" = [
              {
                icon = "hugging-face.svg";
                href = "https://huggingface.co/chat";
              }
            ];
          }
        ];
      }
      {
        "Redes Sociales & Multimedia" = [
          {
            "Reddit" = [
              {
                icon = "reddit.svg";
                href = "https://www.reddit.com/";
              }
            ];
          }
          {
            "Netflix" = [
              {
                icon = "netflix.svg";
                href = "https://netflix.com/";
              }
            ];
          }
          {
            "MyAnimeList" = [
              {
                abbr = "MAL";
                href = "https://myanimelist.net/";
              }
            ];
          }
          {
            "HiAnime" = [
              {
                abbr = "HA";
                href = "https://hianime.to/";
              }
            ];
          }
        ];
      }
      {
        "Productividad" = [
          {
            "GitHub" = [
              {
                icon = "github.svg";
                href = "https://github.com/";
              }
            ];
          }
          {
            "Whatsapp Web" = [
              {
                icon = "whatsapp.svg";
                href = "https://web.whatsapp.com/";
              }
            ];
          }
          {
            "Excalidraw" = [
              {
                icon = "excalidraw.svg";
                href = "https://excalidraw.com/";
              }
            ];
          }
          {
            "Google Drive" = [
              {
                icon = "google-drive.svg";
                href = "https://drive.google.com/";
              }
            ];
          }
          {
            "Google Gmail" = [
              {
                icon = "gmail.svg";
                href = "https://mail.google.com/";
              }
            ];
          }
          {
            "Google Calendar" = [
              {
                icon = "google-calendar.svg";
                href = "https://calendar.google.com/";
              }
            ];
          }
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
          {
            "Jellyfin" = {
              icon = "jellyfin.svg";
              description = "Plataforma para ver tus series y películas en casa";
              href = "https://jellyfin.andrewgigena.dev/";
            };
          }
          {
            "Sonarr" = {
              icon = "sonarr.svg";
              description = "Organiza y descarga series de TV automáticamente";
              href = "https://sonarr.andrewgigena.dev/";
            };
          }
          {
            "Radarr" = {
              icon = "radarr.svg";
              description = "Organiza y descarga películas automáticamente";
              href = "https://radarr.andrewgigena.dev/";
            };
          }
          {
            "Lidarr" = {
              icon = "lidarr.svg";
              description = "Organiza y descarga música automáticamente";
              href = "https://lidarr.andrewgigena.dev/";
            };
          }
          {
            "Readarr" = {
              icon = "readarr.svg";
              description = "Organiza y descarga libros & audiolibros automáticamente";
              href = "https://readarr.andrewgigena.dev/";
            };
          }
        ];
      }
      {
        "Gestión de Servidores" = [
          {
            "Nginx Proxy Manager" = {
              icon = "nginx-proxy-manager.svg";
              description = "Gestor de accesos y seguridad para servidores";
              href = "https://nginx.andrewgigena.dev/";
            };
          }
          {
            "Pihole" = {
              icon = "pi-hole.svg";
              description = "Bloqueador de anuncios para toda tu red";
              href = "https://pihole.andrewgigena.dev/";
            };
          }
          {
            "Homepage Dashboard" = {
              icon = "homepage.png";
              description = "Panel centralizado para gestionar y visualizar tus servicios";
              href = "https://home.andrewgigena.dev/";
            };
          }
          {
            "qBittorrent" = {
              icon = "qbittorrent.svg";
              description = "Cliente para descargar y gestionar torrents";
              href = "https://qbittorrent.andrewgigena.dev/";
            };
          }
        ];
      }
      {
        "Automatización y Sincronización" = [
          {
            "Bazarr" = {
              icon = "bazarr.svg";
              description = "Automatiza la descarga y gestión de subtítulos";
              href = "https://bazarr.andrewgigena.dev/";
            };
          }
          {
            "Prowlarr" = {
              icon = "prowlarr.svg";
              description = "Administra indexadores para búsquedas de contenido";
              href = "https://prowlarr.andrewgigena.dev/";
            };
          }
          {
            "Syncthing (apollo)" = {
              icon = "syncthing.svg";
              description = "Sincronización de archivos entre dispositivos";
              href = "https://syncthing.andrewgigena.dev/";
            };
          }
        ];
      }
      {
        "Monitoreo" = [
          {
            "Uptime Kuma" = {
              icon = "uptime-kuma.svg";
              description = "Estado de salud de todos los servicios";
              href = "https://uptime.andrewgigena.dev/status/default";
              widget = {
                type = "uptimekuma";
                url = "http://localhost:3001";
                slug = "default";
              };
            };
          }
          {
            "Frigate" = {
              icon = "frigate.svg";
              description = "Sistema de videovigilancia con detección inteligente";
              href = "https://frigate.andrewgigena.dev/";
            };
          }
          {
            "OwnTracks" = {
              icon = "owntracks.svg";
              description = "Aplicación para compartir y rastrear ubicaciones";
              href = "https://owntracks-ui.andrewgigena.dev/";
            };
          }
        ];
      }
      {
        "Ofimatica" = [
          {
            "Flatnotes" = {
              icon = "flatnotes.svg";
              description = "Gestor de notas en Markdown, simple y ligero";
              href = "https://notes.andrewgigena.dev/";
            };
          }
        ];
      }
    ];
  };

  # Local services: qBittorrent
  environment.systemPackages = with pkgs; [
    qbittorrent-nox # Download manager
  ];

  systemd.services."qbittorrent-webui" = {
    description = "Starts qBittorrent webui";
    wantedBy = [ "multi-user.target" ];
    script = ''
      ${pkgs.qbittorrent-nox}/bin/qbittorrent-nox
    '';

    serviceConfig = {
      Type = "simple";

      # Memory control
      MemoryAccounting = true;
      MemoryMax = "1G";
      MemorySwapMax = "256M";

      # CPU control
      CPUAccounting = true;
      CPUQuota = "100%"; # Limit to 1 cpu core

      # Reliability
      Restart = "on-failure";
      RestartSec = 10;
    };
  };

  # Local services: Syncthing
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    guiAddress = "0.0.0.0:8384";
    user = "shadows";
    dataDir = "/disks/secondary/data/syncthing";
    configDir = "/disks/secondary/configs/syncthing";
  };

  # Local services: Multimedia
  services.sonarr.enable = true;
  services.readarr.enable = true;
  services.radarr.enable = true;
  services.prowlarr.enable = true;
  services.lidarr.enable = true;
  services.bazarr.enable = true;
  services.jellyfin.enable = true;

  # Docker-based services
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
        "/disks/secondary/configs/nginx/data:/data"
        "/disks/secondary/configs/nginx/letsencrypt:/etc/letsencrypt"
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
        "9180:80/tcp"
      ];

      volumes = [
        "/disks/secondary/configs/pihole/pihole/:/etc/pihole"
        "/disks/secondary/configs/pihole/dnsmasq/:/etc/dnsmasq.d"
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

    owntracks-recorder = {
      image = "owntracks/recorder";
      ports = [
        "8083:8083"
      ];
      environment = {
        OTR_PORT = "0"; # Disable MQTT by setting the environment variable.
      };
      volumes = [
        "/disks/secondary/configs/owntracks:/config"
        "/disks/secondary/data/owntracks:/store"
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

    mariela-strapi-prod = {
      image = "vshadbolt/strapi";
      autoStart = true;
      ports = [ "1337:1337" ];
      volumes = [ "/disks/secondary/marielabarcelo/api:/srv/app" ];
      extraOptions = [
        "--name=mariela-strapi-prod"
        "--network=apollo"
      ];
    };

    mariela-strapi-dev = {
      image = "vshadbolt/strapi";
      autoStart = true;
      ports = [ "1338:1337" ];
      volumes = [ "/disks/secondary/marielabarcelo/dev:/srv/app" ];
      extraOptions = [
        "--name=mariela-strapi-dev"
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
        "/disks/secondary/data/frigate:/media/frigate"
        "/disks/secondary/configs/frigate:/config"
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

    flatnotes = {
      image = "dullage/flatnotes:latest";
      autoStart = true;
      ports = [
        "24824:8080"
      ];
      volumes = [
        "/disks/secondary/data/syncthing/flatnotes:/data"
      ];
      environment = {
        FLATNOTES_AUTH_TYPE = "none";
      };
      extraOptions = [
        "--network=apollo"
      ];
    };

    flaresolverr = {
      image = "ghcr.io/flaresolverr/flaresolverr:latest";
      autoStart = true;
      ports = [
        "8191:8191"
      ];
      environment = {
        LOG_LEVEL = "info";
      };
      extraOptions = [
        "--network=apollo"
      ];
    };

    uptime-kuma = {
      image = "louislam/uptime-kuma:1";
      autoStart = true;
      ports = [ "3001:3001" ];
      volumes = [ "/disks/secondary/configs/uptime-kuma:/app/data" ];
      extraOptions = [
        "--network=host"
        "--dns=127.0.0.1"
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

  systemd.services.redes-auth = {
    description = "Servicio de Autenticación Redes 2025";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];

    serviceConfig = {
      Type = "simple";
      ExecStart = "/home/shadows/redes-obligatorio/redes-auth 15033";
      WorkingDirectory = "/home/shadows/redes-obligatorio";
      Restart = "always";
      RestartSec = 2;
      User = "shadows";
      Environment = "PORT=15033";
    };
  };
}
