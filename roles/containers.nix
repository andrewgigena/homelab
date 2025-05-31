{ pkgs-unstable, ... }:
{
  # Containers
  virtualisation.docker.enable = true;
  virtualisation.podman.enable = true;

  environment.systemPackages = with pkgs-unstable; [
    minikube
    kind
    kubectl
  ];
}
