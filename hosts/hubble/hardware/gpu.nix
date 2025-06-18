{ pkgs, ... }:

{
  # Environment Variables
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD"; # Sets the VAAPI driver as intel-media-driver
    NIXOS_OZONE_WL = "1"; # Allows running Electron/Chromium apps on Wayland
    RUSTICL_ENABLE = "iris"; # Enables RustiCL on Intel GPU
    ANV_DEBUG = "video-decode,video-encode"; # Enables "Vulkan Video"
  };

  # OpenGL and Others
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      mesa # OpenGL, Vulkan, etc.
      mesa.opencl # OpenCL
      intel-media-driver # VAAPI, Video acceleration
      libvdpau-va-gl # VDPAU, Video acceleration
      intel-compute-runtime-legacy1 # OpenCL
      pocl # OpenCL
    ];
  };

  environment.systemPackages = with pkgs; [
    nvtopPackages.intel
    libva-utils
    vdpauinfo
  ];
}
