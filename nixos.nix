{
  pkgs,
  lib,
  ...
}:

{
  # Main time zone for the system
  time.timeZone = "America/Montevideo";

  # Show how many characters are being written during password input
  security.sudo.extraConfig = ''
    Defaults pwfeedback
  '';

  environment.systemPackages = with pkgs; [
    aha
    axel
    bat
    clinfo
    dig
    dmidecode
    dust
    eza
    fd
    file
    fwupd
    git
    glxinfo
    gptfdisk
    htop
    lm_sensors
    mkpasswd
    moreutils
    iperf3
    ncdu
    neovim
    nixd
    nixfmt-rfc-style
    nmap
    ocl-icd
    p7zip
    parted
    pciutils
    powertop
    ripgrep
    rsync
    sysfsutils
    tldr
    trashy
    unrar
    unzip
    usbutils
    vulkan-tools
    wayland-utils
    wget
    wl-clipboard
    xsel
    xxd
  ];

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [
      "root"
      "@wheel"
    ];
    auto-optimise-store = true;
  };

  nixpkgs.config.allowUnfree = true;

  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
    libraries = with pkgs; [
      SDL
      SDL2
      SDL2_image
      SDL2_mixer
      SDL2_ttf
      SDL_image
      SDL_mixer
      SDL_ttf
      alsa-lib
      at-spi2-atk
      at-spi2-core
      atk
      bzip2
      cairo
      cups
      curl
      curlWithGnuTls
      dbus
      dbus-glib
      desktop-file-utils
      e2fsprogs
      expat
      flac
      fontconfig
      freeglut
      freetype
      fribidi
      fuse
      fuse3
      gdk-pixbuf
      glew110
      glib
      gmp
      gst_all_1.gst-plugins-base
      gst_all_1.gst-plugins-ugly
      gst_all_1.gstreamer
      gtk2
      harfbuzz
      icu
      keyutils.lib
      libGL
      libGLU
      libappindicator-gtk2
      libappindicator-gtk3
      libcaca
      libcanberra
      libcap
      libclang.lib
      libdbusmenu
      libdrm
      libdrm
      libgcrypt
      libglvnd
      libgpg-error
      libidn
      libinput
      libjack2
      libjpeg
      libmikmod
      libogg
      libpng12
      libpulseaudio
      librsvg
      libsamplerate
      libthai
      libtheora
      libtiff
      libudev-zero
      libudev0-shim
      libusb1
      libuuid
      libvdpau
      libvorbis
      libvpx
      libxcrypt-legacy
      libxkbcommon
      libxml2
      mesa
      nspr
      nss
      openssl
      openssl
      p11-kit
      pango
      pixman
      python3
      speex
      sqlite
      stdenv.cc.cc
      stdenv.cc.cc
      tbb
      udev
      vulkan-loader
      wayland
      xorg.libICE
      xorg.libSM
      xorg.libX11
      xorg.libXScrnSaver
      xorg.libXcomposite
      xorg.libXcursor
      xorg.libXdamage
      xorg.libXext
      xorg.libXfixes
      xorg.libXft
      xorg.libXi
      xorg.libXinerama
      xorg.libXmu
      xorg.libXrandr
      xorg.libXrender
      xorg.libXt
      xorg.libXtst
      xorg.libXxf86vm
      xorg.libpciaccess
      xorg.libxcb
      xorg.xcbutil
      xorg.xcbutilimage
      xorg.xcbutilkeysyms
      xorg.xcbutilrenderutil
      xorg.xcbutilwm
      xorg.xkeyboardconfig
      xz
      zlib
    ];
  };

  services = {
    libinput.enable = true;
    openssh.enable = true;
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

  # Networking
  networking.useDHCP = lib.mkDefault true;
  networking.networkmanager.enable = true;
  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;
  systemd.services.NetworkManager-wait-online.enable = false;

  # Audio support
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
  };

  # Bluetooth support
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Printing support
  services.printing.enable = true;

  # Enable fish shell
  programs.fish.enable = true;
  programs.fish.shellAliases = {
    nixos = "sudo nixos-rebuild --flake /etc/nixos/#$(hostname)";
    clipdircontent = "/etc/nixos/extra/scripts/clipdircontent.fish";
  };
  users.defaultUserShell = pkgs.fish;

  # It's me Andrew
  users.extraUsers.shadows = {
    description = "Andrew Gigena";
    extraGroups = [
      "wheel" # Permite al usuario ejecutar comandos con privilegios administrativos (sudo).
      "plugdev" # Permite gestionar dispositivos enchufables como USB sin requerir permisos de root.
      "adbusers" # Habilita el acceso a dispositivos Android mediante ADB (Android Debug Bridge).
      "docker" # Autoriza al usuario a ejecutar y administrar contenedores Docker sin sudo.
      "wireshark" # Da acceso para capturar paquetes de red con Wireshark (requiere privilegios especiales).
      "dialout" # Habilita el uso de interfaces seriales (ej. puertos RS-232/USB para dispositivos embebidos o módems).
    ];
    home = "/home/shadows";
    initialHashedPassword = "$y$j9T$r9kBULYu9npZRW/i3V9vF/$g7FqafE1uv205.opfOe0.Sq/ma7WaoXcAW3FHGxUsI7";
    isNormalUser = true;
    linger = true;
    uid = 1000;
    useDefaultShell = true;
  };

  # Missing commands finder
  programs.nix-index.enable = true;
  programs.command-not-found.enable = false;

  # For secure remote access and networking
  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "both";

  # Enable SSD trimming (HDDs are unaffected)
  services.fstrim.enable = true;
}
