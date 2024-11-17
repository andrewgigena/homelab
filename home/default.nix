{ pkgs, inputs, ... }:

{
  imports = [
    ./packages.nix
    ./programs.nix
    ./direnv.nix
  ];

  nixpkgs = {
    overlays = [];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "shadows";
    homeDirectory = "/home/shadows";
    stateVersion = "24.05";
  };

  systemd.user.startServices = "sd-switch";

  home.sessionVariables = with pkgs; {
    GSETTINGS_SCHEMA_DIR = "${gtk4}/share/gsettings-schemas/${gtk4.name}/glib-2.0/schemas";
  };

  _module.args.unstable = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true;
  };
}
