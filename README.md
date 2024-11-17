# NixOS Configuration

This repository contains my personal NixOS configuration files, tailored for multiple machines.

## Features

- **NixOS 24.05** with Flakes support
- **KDE Plasma 6** as the desktop environment on Mimir
- **Home Manager** for user-specific configurations
- Variety of development tools and productivity applications

### Key Components

- **Virtualization**: Support for Docker, QEMU/KVM, and Waydroid
- **Syncthing**: Configured for file synchronization
- **Audio**: PipeWire setup with ALSA, PulseAudio, and JACK support
- **Bluetooth**: Enabled and configured
- **Video Acceleration**: Hardware-specific GPU optimization
- **SSD Optimizations**: BTRFS with compression and noatime options
- **Security**: LUKS encryption for the root partition

## Machines

- **Mimir**: Lenovo ThinkPad T480
- **Kepler**: Custom build Workstation
- **Voyager**: HP Casablanca H710 

## Structure

- `flake.nix`: The entry point of the configuration
- `home/`: User specific configurations managed by Home Manager
- `hosts/`: Device specific configurations
- `modules/`: Reusable NixOS modules
  - `desktop/`: Desktop environment configurations
  - `services/`: Various system services
  - `system/`: Shared configurations across systems

## Usage

### Building the System

To build and switch to a specific configuration, run:
```sh
nixos switch
```

## License

This project is open source and available under the MIT License.
