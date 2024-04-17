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

    ./common/optional/gui/theme.nix
    ./common/optional/gui/wm/hyprland
  ];

  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "23.11";
}
