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

### Mimir (Lenovo ThinkPad T480)

Mimir is configured with optimizations specific to the ThinkPad T480 hardware, including:

- Intel GPU optimizations
- ThinkPad-specific power management
- Custom BTRFS partition layout

### Kepler

PENDING TO MIGRATE FROM ARCH LINUX

## Structure

- `flake.nix`: The entry point of the configuration
- `hosts/`: System-specific configurations
  - `mimir/`: Configuration for the ThinkPad T480
  - `kepler/`: Configuration for Kepler
  - `common/`: Shared configurations across systems
- `modules/`: Reusable NixOS modules
  - `desktop/`: Desktop environment configurations
  - `services/`: Various system services
- `home-manager/`: User-specific configurations managed by Home Manager

## Usage

### Building the System

To build and switch to a specific configuration, run:

For Mimir:
```sh
nixos-mimir
```

For Kepler:
```sh
nixos-kepler
```

## License

This project is open source and available under the MIT License.
