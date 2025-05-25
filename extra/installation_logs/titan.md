# Install NixOS on `titan`
## 1. Format and partition the hard drive
1. Create the **GPT** partition table
    * `sudo parted /dev/mmcblk1 mklabel gpt -s`
2. Create the **UEFI** *FAT32* partition (*which will be `/dev/mmcblk1p1`*)
    * `sudo parted /dev/mmcblk1 mkpart esp fat32 1MiB 512MiB`
    * `sudo parted /dev/mmcblk1 set 1 esp on`
    * `sudo parted /dev/mmcblk1 set 1 boot on`
    * `sudo mkfs.fat -F 32 -n UEFI /dev/mmcblk1p1`
3. Create the **NIXOS** *BTRFS* partition (*which will be `/dev/mmcblk1p2`*)
    * `sudo parted /dev/mmcblk1 mkpart nixos btrfs 512MiB 100%`
    * `sudo mkfs.btrfs -L NixOS /dev/mmcblk1p2`

## 2. Setup BTRFS subvolumes
1. Mount the **NIXOS** partition
    * `sudo mount -t btrfs /dev/mmcblk1p2 /mnt`
2. Create the **ROOT** partition subvolume
    * `sudo btrfs subvolume create /mnt/@root`
3. Create the **HOME** partition subvolume
    * `sudo btrfs subvolume create /mnt/@home`
4. Create the **NIX** partition subvolume
    * `sudo btrfs subvolume create /mnt/@nix`
5. Create the **PERSIST** partition subvolume
    * `sudo btrfs subvolume create /mnt/@persist`
6. Create the **LOG** partition subvolume
    * `sudo btrfs subvolume create /mnt/@log`
7. Unmount the **NIXOS** partition
    * `sudo umount /mnt`

## 3. Mount the partitions for installation
1. Mount the **ROOT** partition subvolume
    * `sudo mount -o subvol=@root,compress=zstd,noatime /dev/mmcblk1p2 /mnt`
2. Create persistent directories on which to mount partitions
    * `sudo mkdir -p /mnt/{boot,home,nix,persist} /mnt/var/log`
3. Mount the **UEFI** partition
    * `sudo mount -t vfat -o defaults,noatime /dev/mmcblk1p1 /mnt/boot`
4. Mount the **HOME** partition subvolume
    * `sudo mount -o subvol=@home,compress=zstd,noatime /dev/mmcblk1p2 /mnt/home`
5. Mount the **NIX** partition subvolume
    * `sudo mount -o subvol=@nix,compress=zstd,noatime /dev/mmcblk1p2 /mnt/nix`
6. Mount the **PERSIST** partition subvolume
    * `sudo mount -o subvol=@persist,compress=zstd,noatime /dev/mmcblk1p2 /mnt/persist`
7. Mount the **LOG** partition subvolume
    * `sudo mount -o subvol=@log,compress=zstd,noatime /dev/mmcblk1p2 /mnt/var/log`

## 4. Generate NixOS configs & install
1. Let NixOS generate template configurations
    * `sudo nixos-generate-config --root /mnt`
2. Make sure all mount points in `hardware-configuration.nix` are **identical** to the previous section
    * `cat /mnt/etc/nixos/hardware-configuration.nix`
3. See what bootloader is used on the `configuration.nix` file
4. Clone the homelab repo on another computer and create a host based on other hosts and the generated `configuration.nix` and `hardware-configuration.nix`
5. Push the changes when finished, clone the repo on the target device.
4. Start the installer
    * `sudo nixos-install --root /mnt --flake /mnt/etc/nixos/#titan`
    * `sudo nixos-enter --root /mnt -c 'passwd username'`
    * `sudo reboot`
