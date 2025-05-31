{ pkgs, pkgs-unstable, ... }:

let
  llama-cpp-latest =
    (pkgs-unstable.llama-cpp.overrideAttrs (old: {
      version = "5295";
      src = pkgs.fetchFromGitHub {
        owner = "ggml-org";
        repo = "llama.cpp";
        rev = "b5295";
        sha256 = "sha256-E+pElyC4tS9DYtX0lxC244vOdpSZYYsNECIZM+LMREU="; # ← fill in with 'nix run nixpkgs#nix-prefetch-github -- ggml-org llama.cpp --rev b5295'
      };
    })).override
      {
        vulkanSupport = true;
        openclSupport = true;
      };

  whisper-cpp-mod = pkgs-unstable.whisper-cpp.override {
    vulkanSupport = true;
  };
in
{
  environment.systemPackages = with pkgs-unstable; [
    llama-cpp-latest
    whisper-cpp-mod
  ];
}
