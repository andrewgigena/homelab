{ pkgs, pkgs-unstable, ... }:

{
  # Multiarch Emulation
  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
    "riscv64-linux"
  ];

  # Enable Android ADB and Fastboot support
  programs.adb.enable = true;
  services.udev.packages = [ pkgs.android-udev-rules ];
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="2e04", MODE="0660", GROUP="adbusers", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTR{idVendor}=="2e04", ATTR{idProduct}=="c009", SYMLINK+="android_adb"
    SUBSYSTEM=="usb", ATTR{idVendor}=="2e04", ATTR{idProduct}=="c009", SYMLINK+="android_fastboot"
  '';

  # Development packages
  environment.systemPackages = [
    # System/Development tooling
    pkgs-unstable.cpio # Support for cpio
    pkgs-unstable.flashrom # Flash Chips Flasher
    pkgs-unstable.innoextract # Extractor of content from .exe installers
    pkgs-unstable.act # Simulator of GitHub Actions using Docker
    pkgs-unstable.android-tools # Android tooling for development and OS manipulation
    pkgs-unstable.biome # Formatter and linter for JavaScript
    pkgs-unstable.cambalache
    pkgs-unstable.cmake # Build System
    pkgs-unstable.dbeaver-bin
    pkgs-unstable.devenv
    pkgs-unstable.dtc # Device Tree compiler
    pkgs-unstable.gdb
    pkgs-unstable.gh # GitHub CLI tool
    pkgs-unstable.jq # Formatter and query builder for JSON
    pkgs-unstable.okteta
    pkgs-unstable.pipx # Installer for pip programs in a sandbox
    pkgs-unstable.poetry # Package manager for Python
    pkgs-unstable.ruff # Formatter and linter for Python
    pkgs-unstable.uv # Package manager for Python
    pkgs-unstable.universal-ctags

    # Code editors / IDEs
    pkgs.vscode
    pkgs-unstable.zed-editor
    pkgs-unstable.jetbrains-toolbox

    # Programming Languages
    pkgs-unstable.clang # C / C++
    pkgs-unstable.dotnetCorePackages.dotnet_9.sdk # C# / .NET
    pkgs-unstable.nodejs # Javascript
    pkgs-unstable.python3 # Python 3
    pkgs-unstable.rustup # Rust

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

    # Containerization
    pkgs-unstable.distrobox
  ];
}
