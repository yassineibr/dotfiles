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
    ./common/optional/gui/wm/hyprland/waybar.nix
    # ./common/optional/gui/wm/hyprland/ags.nix
    ./common/optional/gui/terminal/kitty.nix
    # ./common/optional/gui/terminal/foot.nix
  ];

  wayland.windowManager.hyprland = {
    settings = {
      monitor = [
        "HDMI-A-1,preferred,auto-right,1"
        "desc:Dell Inc. DELL S2721HN 9GJ3V83,1920x1080@74.97,auto-right,1"
        "desc:Microstep MAG 255F E20 BC2M435300423,1920x1080@120,auto-right,1"
        "eDP-1,preferred,auto-left,1"
      ];

      env = [
        "AQ_DRM_DEVICES,/dev/dri/card0:/dev/dri/card2:/dev/dri/card1"
      ];
    };
  };

  home.stateVersion = "23.11";
}
