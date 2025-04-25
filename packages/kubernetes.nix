{ pkgs, pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs; [
    minikube
    kind
    kubectl
  ];
}
