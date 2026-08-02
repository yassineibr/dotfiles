{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./common/core
    ./common/core/nushell.nix
    ./common/optional/packages.nix

    ./common/optional/apps/git.nix
    ./common/optional/apps/direnv.nix

    ./common/optional/xdg-settings.nix

    ./common/optional/apps/nvim.nix
    ./common/optional/apps/sshs.nix
    ./common/optional/apps/yazi.nix

    ./common/optional/gui/theme.nix

    ./common/optional/gui/wm/hyprland
    ./common/optional/gui/wm/hyprland/nvidia.nix
    ./common/optional/gui/wm/hyprland/noctalia.nix
    # ./common/optional/gui/wm/hyprland/waybar.nix
    # ./common/optional/gui/wm/hyprland/ags.nix
    ./common/optional/gui/terminal/kitty.nix
    # ./common/optional/gui/terminal/foot.nix
  ];

  wayland.windowManager.hyprland = {
    settings = {
      monitor = [
        {
          output = "HDMI-A-1";
          mode = "preferred";
          position = "auto-right";
          scale = 1;
        }
        {
          output = "desc:Dell Inc. DELL S2721HN 9GJ3V83";
          mode = "1920x1080@74.97";
          position = "auto-right";
          scale = 1;
        }
        {
          output = "desc:Microstep MAG 255F E20 BC2M435300423";
          mode = "1920x1080@120";
          position = "auto-right";
          scale = 1;
        }
        {
          output = "eDP-1";
          mode = "preferred";
          position = "auto-left";
          scale = 1;
        }
      ];

      env = [
        {
          _args = [
            "AQ_DRM_DEVICES"
            "/dev/dri/card0:/dev/dri/card2:/dev/dri/card1"
          ];
        }
      ];
    };
  };

  home.stateVersion = "23.11";
}
