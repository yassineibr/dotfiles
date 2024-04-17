{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./common/core

    ./common/optional/apps/git.nix
    ./common/optional/apps/direnv.nix

    ./common/optional/xdg-settings.nix

    ./common/optional/apps/nvim.nix

    ./common/optional/gui/theme.nix
    ./common/optional/gui/wm/hyprland
  ];

  wayland.windowManager.hyprland = {
    settings = {
      monitor = [
        "eDP-1,preferred,auto,1.2"
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "23.11";
}
