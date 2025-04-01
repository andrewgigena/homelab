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
      stdenv.cc.cc
      fuse3
      openssl
      curl
      libxkbcommon
      libudev-zero
      libappindicator-gtk3
      libdrm
      libglvnd
      libusb1
      libuuid
      libxml2
      libinput
      mesa
      fontconfig
      freetype
      sqlite
    ];
  };

  services = {
    libinput.enable = true;
    openssh.enable = true;
  };
}
