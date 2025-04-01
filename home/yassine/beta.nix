{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./common/core
    ./common/optional/packages.nix

    ./common/optional/apps/git.nix
    ./common/optional/apps/direnv.nix

    ./common/optional/xdg-settings.nix

    ./common/optional/apps/nvim.nix

    ./common/optional/gui/theme.nix

    ./common/optional/gui/wm/hyprland
    # ./common/optional/gui/wm/hyprland/touch.nix
    # ./common/optional/gui/wm/hyprland/waybar.nix
    ./common/optional/gui/wm/hyprland/ags.nix
  ];

  wayland.windowManager.hyprland = {
    settings = {
      monitor = [
        "eDP-1,preferred,auto,1.2"
        "HDMI-A-1,preferred,auto-up,1"
      ];
    };
  };

  home.stateVersion = "23.11";
}
