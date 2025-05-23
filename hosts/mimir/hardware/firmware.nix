{ pkgs, ... }:

{
  # Firwmare
  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableAllFirmware = true;
  services.fwupd.enable = true;
}
