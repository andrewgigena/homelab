{ pkgs, pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs; [
    (pkgs-unstable.llama-cpp.override {
      vulkanSupport = true;
      rocmSupport = true;
      # openclSupport = true;
      # blasSupport = true;
    })
  ];
}
