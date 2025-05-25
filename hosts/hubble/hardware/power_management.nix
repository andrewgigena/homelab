{ pkgs, ... }:

{
  # Power Management
  powerManagement.enable = true;
  services.thinkfan.enable = true;
  services.thermald.enable = true;
  services.thinkfan.levels = [
    [
      0
      0
      55
    ]
    [
      1
      48
      60
    ]
    [
      2
      50
      61
    ]
    [
      3
      52
      63
    ]
    [
      6
      56
      65
    ]
    [
      7
      60
      75
    ]
    [
      "level full-speed"
      70
      32767
    ]
  ];
}
