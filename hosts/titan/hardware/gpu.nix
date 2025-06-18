{ pkgs, ... }:

{
  # Environment Variables
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
    NIXOS_OZONE_WL = "1";
  };

  # OpenGL and Others
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # Video acceleration
      libvdpau-va-gl # Video acceleration
    ];
  };
}
