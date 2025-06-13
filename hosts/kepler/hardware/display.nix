{ pkgs, ... }:

{
  hardware.display = {
    edid.enable = true;
    edid.packages = [
      # Panavox B2176 1080x1920
      # - Added product name
      # - Enabled 75hz on all resolutions
      # - Removed unused resolutions
      # - Added YCbCr 4:4:4 deep color
      (pkgs.runCommand "panavox.edid.bin" { } ''
        mkdir -p "$out/lib/firmware/edid"
        base64 -d > "$out/lib/firmware/edid/panavox.edid.bin" <<'EOF'
        AP///////wAhYwAAAQAAABAZAQOAMBt46t31plQ4riUNT1QEQwDRz9HAAQEBAQEBAQEBAQEBg0iAGHE4LUBYLEUA4A4RAAAeAjqAGHE4LUBYLEUA4A4RAAAeAAAA/QAeSx5SEwAKICAgICAgAAAA/ABQQU5BVk9YIEIyMTc2Ae4CAxhwRJAfBRQjCQcHgwEAAGYDDAAQAIlCJIAYcRwWIFgsJQDghxAAAJ4BHYAYcRwWIFgsJQDghxAAAJ4BHYDQchwWIBAsJYDghxAAAJ4AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAvQ==
        EOF
      '')
    ];

    outputs = {
      "HDMI-A-2".edid = "panavox.edid.bin";
    };
  };
}
