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
    ./common/optional/gui/wm/hyprland/nvidia.nix
    ./common/optional/gui/wm/hyprland/waybar.nix
    # ./common/optional/gui/wm/hyprland/ags.nix
  ];

  wayland.windowManager.hyprland = {
    settings = {
      monitor = [
        "HDMI-A-1,preferred,auto-right,1"
      ];
    };
  };

  # wayland.windowManager.hyprland.settings.exec-once = [
  #    "${pkgs.hyprpanel}/bin/hyprpanel"
  #  ];

  home.stateVersion = "23.11";
}
