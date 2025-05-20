{ pkgs, pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs; [
    obsidian    # Notes
    typst       # Markup-based typesetting system
    onlyoffice-desktopeditors # Office suite
    anki-bin # Flashcard program
    poppler_utils # PDF utilities
  ];
}
