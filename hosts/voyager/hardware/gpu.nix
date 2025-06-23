{ pkgs, ... }:

{
  # Environment Variables
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "i965"; # Sets the VAAPI driver as intel-media-driver
    NIXOS_OZONE_WL = "1"; # Allows running Electron/Chromium apps on Wayland
    RUSTICL_ENABLE = "radeonsi,llvmpipe"; # Enables RustiCL
    RADV_DEBUG = "video-decode,video-encode"; # Enables "Vulkan Video"
  };

  # OpenGL and Others
  hardware.amdgpu.legacySupport.enable = true;
  hardware.amdgpu.initrd.enable = true;
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      mesa # OpenGL, Vulkan, etc.
      mesa.opencl # OpenCL
      intel-vaapi-driver # VAAPI, Video acceleration
      libvdpau-va-gl # VDPAU, Video acceleration
      pocl # OpenCL
    ];
  };

  environment.systemPackages = with pkgs; [
    nvtopPackages.intel
    nvtopPackages.amd
    libva-utils
    vdpauinfo
  ];
}
