{ pkgs, ... }:
{
  # Containers
  virtualisation.docker.enable = true;
  virtualisation.podman.enable = true;

  environment.systemPackages = with pkgs; [
    minikube
    kind
    kubectl
  ];
}
