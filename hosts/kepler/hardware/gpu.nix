{ pkgs, ... }:

{
  # Define GPU-related environment variables
  environment.sessionVariables = {
    ROC_ENABLE_PRE_VEGA = "1";
    RUSTICL_ENABLE = "radeonsi";
  };

  # GPU support: enable ROCm and OpenCL for AMD GPU
  nixpkgs.config.rocmSupport = true;

  # AMDGPU and graphics stack configuration
  hardware = {
    amdgpu.initrd.enable = true;
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        rocmPackages_5.clr
        rocmPackages_5.clr.icd
        rocmPackages_5.rocminfo
        rocmPackages_5.rocm-runtime
        mesa
        mesa.opencl
      ];
    };
  };

  # Add GPU utilities to system packages
  environment.systemPackages = with pkgs; [
    rocmPackages_5.rocblas
    rocmPackages_5.rocminfo
    rocmPackages_5.rocm-runtime
    rocmPackages_5.hipblas
    rocmPackages_5.clr
  ];
}
