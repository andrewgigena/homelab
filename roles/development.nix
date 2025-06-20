{ pkgs, ... }:

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
  environment.systemPackages = with pkgs; [
    # System/Development tooling
    cpio # Support for cpio
    flashrom # Flash Chips Flasher
    innoextract # Extractor of content from .exe installers
    act # Simulator of GitHub Actions using Docker
    android-tools # Android tooling for development and OS manipulation
    biome # Formatter and linter for JavaScript
    cambalache
    cmake # Build System
    dbeaver-bin
    devenv
    dtc # Device Tree compiler
    gdb
    gh # GitHub CLI tool
    jq # Formatter and query builder for JSON
    okteta
    pipx # Installer for pip programs in a sandbox
    poetry # Package manager for Python
    ruff # Formatter and linter for Python
    uv # Package manager for Python
    universal-ctags

    # Code editors / IDEs
    vscode
    zed-editor
    jetbrains-toolbox

    # Programming Languages
    clang # C / C++
    dotnetCorePackages.dotnet_9.sdk # C# / .NET
    nodejs # Javascript
    python3 # Python 3
    rustup # Rust

    # Reverse engineering
    radare2
    ghidra

    # Databases
    sqlite

    # Nix
    devbox

    virtiofsd

    # Binwalk v3
    binwalk

    # Containerization
    distrobox
  ];
}
