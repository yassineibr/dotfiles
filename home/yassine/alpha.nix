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
    # ./common/optional/gui/wm/hyprland/waybar.nix
    ./common/optional/gui/wm/hyprland/ags.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "23.11";
}
