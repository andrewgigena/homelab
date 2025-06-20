# Andrew's HomeLab
This repository contains my personal NixOS configuration files, tailored for multiple machines. This repository and its configurations are open source and available under the MIT License.

My homelab configuration follows a modular structure centered around a central `flake.nix` that orchestrates all systems. I've organized the infrastructure into reusable roles and host-specific configurations, creating a balance between shared functionality and individual machine needs.

The foundation is built using Nix flakes with two primary package channels - the stable `nixos-24.11` branch for core system components, and `nixpkgs-andrew` for custom builded apps. This hybrid approach lets me maintain system stability while still accessing bleeding-edge software where it matters most.

Four primary systems comprise the homelab: **Apollo** (server infrastructure), **Kepler** (main workstation), **Hubble** (main mobile workstation), and **Voyager** (secondary mobile workstation). Each device is named after space exploration milestones and celestial objects and they are defined through a role-based composition system. I've created dedicated role modules for common functionalities:
- **Containers**: Docker/Podman support with Kubernetes tooling
- **Development**: Cross-compilation environments and embedded toolchains
- **Electronics**: Hardware debugging tools, logic analyzers, and microcontroller IDEs for embedded development
- **Gaming**: Steam integration with performance optimizations
- **Machine Learning**: LLM and related apps
- **Virtualization**: QEMU/KVM virtualization stack with secure boot support, TPM emulation, and SPICE integration for managing virtual machines
- **Workstation**: Plasma 6 desktop environment with productivity apps

Host configurations inherit from these roles while adding device-specific hardware adjustments. For example, **kepler** includes extensive GPU optimizations for AMD ROCm workloads, while **hubble** incorporates a special fingerprint reader module. The architecture allows me to enable complex capabilities like Android development environments or electronics debugging tools across multiple machines with minimal duplication. Common system-wide configurations live in `nixos.nix` handling the essentials.

The configuration emphasizes reproducibility - all systems can be rebuilt from scratch using their declarative specifications, while persistent data survives through dedicated btrfs subvolumes. This architecture lets me experiment freely knowing I can always roll back to a known-good state.
