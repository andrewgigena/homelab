{ pkgs, ... }:

{
  # Environment Variables
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "i965";
    NIXOS_OZONE_WL = "1";
    RUSTICL_ENABLE = "iris";
  };

  # Video acceleration
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };

  # OpenGL and Others
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      libvdpau-va-gl # Video acceleration
      intel-compute-runtime # OpenCL
      mesa.opencl
    ];
  };
}
