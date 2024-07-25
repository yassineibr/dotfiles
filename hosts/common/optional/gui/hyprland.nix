{ inputs, pkgs, ... }:
{
  imports = [
    ../cache/hyprland.nix
    ../services/greetd.nix
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

  hardware.opengl = {
    package = pkgs.unstable.mesa.drivers;

    # if you also want 32-bit support (e.g for Steam)
    # driSupport32Bit = true;
    package32 = pkgs.unstable.pkgsi686Linux.mesa.drivers;
  };

  security.pam.services.hyprlock = { };
}
