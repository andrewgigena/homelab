{ pkgs, ... }:

{
  # Define GPU-related environment variables
  environment.sessionVariables = {
    ROC_ENABLE_PRE_VEGA = "1"; # Enables ROCM on pre-Vega AMD GPUs
    NIXOS_OZONE_WL = "1"; # Allows running Electron/Chromium apps on Wayland
    RUSTICL_ENABLE = "radeonsi"; # Enables RustiCL on AMD GPU
    RADV_PERFTEST = "video_decode,video_encode"; # Enables "Vulkan Video"
  };

  # AMDGPU and graphics stack configuration
  hardware = {
    amdgpu.initrd.enable = true;
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        mesa # OpenGL, Vulkan, etc.
        mesa.opencl # OpenCL
        pocl # OpenCL
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    amdgpu_top
    nvtopPackages.amd
    libva-utils
    vdpauinfo
  ];
}
