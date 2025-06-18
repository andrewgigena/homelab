{ pkgs, ... }:

{
  # Environment Variables
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
    NIXOS_OZONE_WL = "1";
    RUSTICL_ENABLE = "iris";
  };

  # OpenGL and Others
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # Video acceleration
      libvdpau-va-gl # Video acceleration
      intel-compute-runtime # OpenCL
      mesa.opencl
    ];
  };

  environment.systemPackages = with pkgs; [
      intel-compute-runtime
  ];
}
