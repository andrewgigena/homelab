{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # System/Development tooling
    cpio                                        # Support for cpio
    flashrom                                    # Flash Chips Flasher
    distrobox
    innoextract                                # Extractor of content from .exe installers
    pmbootstrap                                # PostmarketOS manager
    libsForQt5.kompare
    act                                        # Simulator of GitHub Actions using Docker
    android-studio
    android-tools                              # Android tooling for development and OS manipulation
    biome                                      # Formatter and linter for JavaScript
    cambalache
    cargo-cross                                # Cross compiler for Rust
    cmake                                      # Build System
    ctags
    dbeaver-bin
    devenv
    dtc                                        # Device Tree compiler
    gdb
    gh                                         # GitHub CLI tool
    jetbrains.idea-ultimate                    # Games
    jetbrains.pycharm-community
    jetbrains.rust-rover
    jq                                         # Formatter and query builder for JSON
    okteta
    pipx                                       # Installer for pip programs in a sandbox
    poetry                                     # Package manager for Python
    ruff                                       # Formatter and linter for Python
    uv                                         # Package manager for Python
    vscode
    #zed-editor

    # Programming Languages
    clang                                      # C / C++
    deno                                       # Javascript / Typescript
    dotnet-sdk                                 # .Net / C#
    flutter                                    # Dart / Flutter
    go                                         # Go
    nodejs                                     # Javascript
    python3                                    # Python 3
    rustup                                     # Rust
    zig

    # Language Server Protocols
    clang-tools                                # C / C++
    dockerfile-language-server-nodejs          # Docker
    gopls                                      # Go
    kdePackages.qtdeclarative                 # QML
    lemminx                                    # XML
    nil                                        # Nix
    nodePackages.bash-language-server          # Bash
    nodePackages.typescript-language-server    # Javascript / Typescript
    omnisharp-roslyn                          # C#
    python311Packages.python-lsp-server        # Python 3.11
    vscode-langservers-extracted               # HTML / CSS / LESS / SCSS / Json / Eslint
    yaml-language-server                       # YAML

    # Databases
    sqlite
  ];
}
