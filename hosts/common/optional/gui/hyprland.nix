{
  inputs,
  pkgs,
  ...
}: {
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
  };

  security.pam.services.hyprlock = {};
}
