{ pkgs, pkgs-unstable, ... }:

{
  home.packages = [
    # System/Development tooling
    pkgs-unstable.cpio                                        # Support for cpio
    pkgs-unstable.flashrom                                    # Flash Chips Flasher
    pkgs-unstable.distrobox
    pkgs-unstable.innoextract                                # Extractor of content from .exe installers
    pkgs-unstable.libsForQt5.kompare
    pkgs-unstable.act                                        # Simulator of GitHub Actions using Docker
    #pkgs-unstable.android-studio
    pkgs-unstable.android-tools                              # Android tooling for development and OS manipulation
    pkgs-unstable.biome                                      # Formatter and linter for JavaScript
    pkgs-unstable.cambalache
    pkgs-unstable.cmake                                      # Build System
    pkgs-unstable.dbeaver-bin
    pkgs-unstable.devenv
    pkgs-unstable.dtc                                        # Device Tree compiler
    pkgs-unstable.gdb
    pkgs-unstable.gh                                         # GitHub CLI tool
    #pkgs-unstable.jetbrains.idea-ultimate                    # Games
    #pkgs-unstable.jetbrains.pycharm-community
    #pkgs-unstable.jetbrains.rust-rover
    pkgs-unstable.jq                                         # Formatter and query builder for JSON
    pkgs-unstable.okteta
    pkgs-unstable.pipx                                       # Installer for pip programs in a sandbox
    pkgs-unstable.poetry                                     # Package manager for Python
    pkgs-unstable.ruff                                       # Formatter and linter for Python
    pkgs-unstable.uv                                         # Package manager for Python
    pkgs.vscode
    #pkgs-unstable.zed-editor
    pkgs-unstable.universal-ctags

    # Programming Languages
    pkgs-unstable.clang                                      # C / C++
    pkgs-unstable.deno                                       # Javascript / Typescript
    pkgs-unstable.dotnet-sdk                                 # .Net / C#
    pkgs-unstable.flutter                                    # Dart / Flutter
    pkgs-unstable.go                                         # Go
    pkgs-unstable.nodejs                                     # Javascript
    pkgs-unstable.python3                                    # Python 3
    pkgs-unstable.rustup                                     # Rust
    pkgs-unstable.zig

    # Language Server Protocols
    pkgs-unstable.clang-tools                                # C / C++
    pkgs-unstable.dockerfile-language-server-nodejs          # Docker
    pkgs-unstable.gopls                                      # Go
    pkgs-unstable.kdePackages.qtdeclarative                 # QML
    pkgs-unstable.lemminx                                    # XML
    pkgs-unstable.nil                                        # Nix
    pkgs-unstable.nodePackages.bash-language-server          # Bash
    pkgs-unstable.nodePackages.typescript-language-server    # Javascript / Typescript
    pkgs-unstable.omnisharp-roslyn                          # C#
    pkgs-unstable.python311Packages.python-lsp-server        # Python 3.11
    pkgs-unstable.vscode-langservers-extracted               # HTML / CSS / LESS / SCSS / Json / Eslint
    pkgs-unstable.yaml-language-server                       # YAML
    
    # Reverse engineering
    pkgs.radare2
    pkgs.ghidra

    # Databases
    pkgs-unstable.sqlite

    # Nix
    pkgs.devbox

    pkgs.virtiofsd

    # Binwalk v3
    pkgs-unstable.binwalk
  ];
}
