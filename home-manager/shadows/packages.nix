{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Internet
    google-chrome
    firefox
    telegram-desktop
    thunderbird

    # Games
    steam

    # Tools
    obsidian
    syncthing
    bitwarden
    yakuake

    # Multimedia
    vlc
    inkscape
    gimp
    qbittorrent
    tor-browser
    kdePackages.kdeconnect-kde
    mpv
    ffmpeg
    audacity
    obs-studio
    imagemagick

    # Development
    jetbrains.rust-rover
    jetbrains.pycharm-community
    jetbrains.idea-ultimate
    android-studio
    vscode
    zed-editor
    dbeaver-bin
    rustup
    clang
    nodejs
    direnv
    #gnome-builder
    deno
    devenv
    cambalache
    #kdevelop
    okteta

    # Language Server Protocols
    nodePackages.bash-language-server            # Bash
    clang-tools                                  # C / C++
    vscode-langservers-extracted                 # HTML / CSS / LESS / SCSS / Json / Eslint
    omnisharp-roslyn                             # C#
    dockerfile-language-server-nodejs            # Docker
    dart                                         # Dart / Flutter
    gopls                                        # Go
    nodePackages.typescript-language-server      # Javascript / Typescript
    python311Packages.python-lsp-server          # Python 3.11
    kdePackages.qtdeclarative                    # QML
    lemminx                                      # XML
    yaml-language-server                         # YAML
    nil                                          # Nix

    # Debuggers
    gdb
    ctags

  ];
}
