{ pkgs, ... }:

{
  time.timeZone = "America/Montevideo";


  # Show how many characters are being written during password input
  security.sudo.extraConfig = ''
    Defaults pwfeedback
  '';

  environment.systemPackages = with pkgs; [
    amdgpu_top
    axel
    bat
    dig
    dust
    dmidecode
    eza
    fd
    file
    fwupd
    git
    htop
    lm_sensors
    mkpasswd
    moreutils
    ncdu
    neovim
    nmap
    parted
    p7zip
    unrar
    unzip
    gptfdisk
    ripgrep
    rsync
    tldr
    wget
    wl-clipboard
    powertop
    aha
    pciutils
    clinfo
    glxinfo
    vulkan-tools
    wayland-utils
    usbutils
    trashy
    xxd
    ocl-icd
    xsel
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.trusted-users = ["root" "@wheel"];
  nix.settings.auto-optimise-store = true;
  nix.gc.automatic = true;
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
  };
}
