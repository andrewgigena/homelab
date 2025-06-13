{ pkgs, ... }:

{
  # Define GPU-related environment variables
  environment.sessionVariables = {
    ROC_ENABLE_PRE_VEGA = "1";
    RUSTICL_ENABLE = "radeonsi";
    RADV_PERFTEST = "video_decode,video_encode";
  };

  # AMDGPU and graphics stack configuration
  hardware = {
    amdgpu.initrd.enable = true;
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        mesa
        mesa.opencl
      ];
    };
  };

}
