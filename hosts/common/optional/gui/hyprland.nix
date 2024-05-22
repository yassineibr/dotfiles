{ inputs, pkgs, ... }:
{
  imports = [
    ../cache/hyprland.nix
    ./xdg.nix
  ];
  # Fix wayland for electron based apps
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  hardware.brillo.enable = true;

  services.gvfs.enable = true;

  # Piper service (logitech mouse)
  services.ratbagd.enable = true;

  services.upower.enable = true;

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    # package = pkgs.unstable.hyprland;
  };

  security.pam.services.hyprlock = { };
}
