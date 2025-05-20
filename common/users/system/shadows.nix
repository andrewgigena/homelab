{ pkgs, pkgs-unstable, ... }:

{
  programs.fish.enable = true;
  programs.fish.shellAliases.nixos = "sudo nixos-rebuild --flake /etc/nixos/#$(hostname)";
  users.defaultUserShell = pkgs-unstable.fish;
  users.extraUsers  = {
    shadows = {
      description = "Andrew Gigena";
      extraGroups = [
        "wheel"       # Permite al usuario ejecutar comandos con privilegios administrativos (sudo).
        "plugdev"     # Permite gestionar dispositivos enchufables como USB sin requerir permisos de root.
        "adbusers"    # Habilita el acceso a dispositivos Android mediante ADB (Android Debug Bridge).
        "docker"      # Autoriza al usuario a ejecutar y administrar contenedores Docker sin sudo.
        "wireshark"   # Da acceso para capturar paquetes de red con Wireshark (requiere privilegios especiales).
        "dialout"     # Habilita el uso de interfaces seriales (ej. puertos RS-232/USB para dispositivos embebidos o módems).
      ]
      home = "/home/shadows";
      initialHashedPassword = "$y$j9T$r9kBULYu9npZRW/i3V9vF/$g7FqafE1uv205.opfOe0.Sq/ma7WaoXcAW3FHGxUsI7";
      isNormalUser = true;
      linger = true;
      uid = 1000;
      useDefaultShell = true;
    };
  };

  # Missing commands finder
  programs.nix-index.enable = true;
  programs.command-not-found.enable = false;
}
