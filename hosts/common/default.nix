{ pkgs, ... }:

{
  imports = [
    ./filesystems.nix
    ./locale.nix
    ./nix.nix
    # Add other common configuration files here
  ];

  environment.systemPackages = with pkgs; [
    amdgpu_top          # GPU usage visualizer
    axel                # Download manager
    bat                 # Alternative to cat
    binwalk             # File/Binary Analyzer
    dig                 # DNS Analyzer
    dust                # File size usage explorer
    eza                 # Alternative to ls
    fd                  # Alternative to find
    file                # File type
    git                 # Coding
    htop                # System usage monitoring
    lm_sensors          # Temperature monitoring
    mkpasswd            # ?
    moreutils           # sponge command
    ncdu                # File size usage explorer
    neovim              # Text editor
    nmap                # Netork Analyzer
    parted		# Partition Manager
    p7zip               # 7z Support
    qemu                # Virtual machine and architecture emulation
    ripgrep             # Fast grep
    rsync               # The cp for network things
    tldr                # Man made easy
    wget                # Download manager
    wl-clipboard        # Command output to clipboard for Wayland
  ];

  # Add other common configurations here
}
