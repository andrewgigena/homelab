{ pkgs, pkgs-andrew, ... }:

let
  llama-cpp-latest =
    (pkgs-andrew.llama-cpp.overrideAttrs (old: {
      version = "5711";
      src = pkgs.fetchFromGitHub {
        owner = "ggml-org";
        repo = "llama.cpp";
        rev = "b5711";
        sha256 = "sha256-MysIyBn05x9HYuKwCfHh0fZvAFr2QReRLoMRO9lrrwI="; # ← fill in with 'nix run nixpkgs#nix-prefetch-github -- ggml-org llama.cpp --rev b5295'
      };
    })).override
      {
        vulkanSupport = true;
        openclSupport = true;
      };

  whisper-cpp-mod = pkgs-andrew.whisper-cpp.override {
    vulkanSupport = true;
  };
in
{
  environment.systemPackages = with pkgs-andrew; [
    # llama-cpp-latest
    # whisper-cpp-mod
    vulkan-caps-viewer
    opencl-caps-viewer
  ];
}
