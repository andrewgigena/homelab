{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Internet
    firefox                                     # Web Browser
    google-chrome                               # Web Browser
    qbittorrent                                 # Torrents
    telegram-desktop                            # Instant Messaging
    thunderbird                                 # Email manager
    tor-browser                                 # Web Browser
    zerotierone                                 # VPN by Zerotier

    # Games
    cemu                                        # Nintendo Wii U Emulator
    gamemode                                    # Acelerador de sistema para Juegos
    steam                                       # Steam

    # Utilities and Others
    anydesk                                     # Desktop sharing and remote support
    bitwarden                                   # Password manager
    cpio                                        # Support for cpio
    flashrom                                    # Flash Chips Flasher
    helvum                                      # Pipewire manager
    innoextract                                 # Extractor of content from .exe installers
    obsidian                                    # Notes
    ollama                                      # Server/Client for LLM
    pmbootstrap                                 # PostmarketOS manager
    syncthing                                   # Sync files between computers
    yakuake                                     # Dropdown Terminal

    # Multimedia
    audacity                                    # Audio editor
    ffmpeg                                      # The ultimate media tool
    gimp                                        # Image editor
    imagemagick                                 # Image conversor
    inkscape                                    # Vectors image editor
    kdePackages.kdeconnect-kde                  # Remote access to computer from my phone
    mediainfo                                   # Info about audio/video/subtitle
    mpv                                         # Video reproductor
    obs-studio                                  # Audio/Video recoder
    vlc                                         # Video reproductor
    yt-dlp                                      # Download videos from YouTube

    # Development tooling
    act                                         # Simulator of GitHub Actions using Docker
    android-studio
    android-tools                               # Android tooling for development and OS manipulation
    biome                                       # Formatter and linter for JavaScript
    cambalache
    cargo-cross                                 # Cross compiler for Rust
    cmake                                       # Build System
    ctags
    dbeaver-bin
    devenv
    dtc                                         # Device Tree compiler
    gdb
    gh                                          # GitHub CLI tool
    jetbrains.idea-ultimate
    jetbrains.pycharm-community
    jetbrains.rust-rover
    jq                                          # Formatter and query builder for JSON
    okteta
    pipx                                        # Installer for pip programs in a sandbox
    poetry                                      # Package manager for Python
    ruff                                        # Formatter and linter for Python
    uv                                          # Package manager for Python
    vscode
    zed-editor

    # Programming Languages
    clang                                       # C / C++
    deno                                        # Javascript / Typescript
    dotnet-sdk                                  # .Net / C#
    flutter                                     # Dart / Flutter
    go                                          # Go
    nodejs                                      # Javascript
    python3                                     # Python 3
    rustup                                      # Rust

    # Language Server Protocols
    clang-tools                                 # C / C++
    dockerfile-language-server-nodejs           # Docker
    gopls                                       # Go
    kdePackages.qtdeclarative                   # QML
    lemminx                                     # XML
    nil                                         # Nix
    nodePackages.bash-language-server           # Bash
    nodePackages.typescript-language-server     # Javascript / Typescript
    omnisharp-roslyn                            # C#
    python311Packages.python-lsp-server         # Python 3.11
    vscode-langservers-extracted                # HTML / CSS / LESS / SCSS / Json / Eslint
    yaml-language-server                        # YAML


  ];
}
