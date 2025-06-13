{ pkgs-unstable, ... }:
{
  environment.systemPackages = with pkgs-unstable; [
    gimp # Image editor
    krita # Painting editor
    inkscape # Vectors image editor
    kdePackages.kdenlive # Video editor
    davinci-resolve # Video editor
    freecad-qt6 # 2D/3D parametric CAD
    audacity # Audio editor
    obs-studio # Audio/Video recoder
    ardour # Digital Audio Workstation
    lmms # Digital Audio Workstation
    zynaddsubfx # Audio synthesizer
    hydrogen # Drum machine
  ];
}
