{
  pkgs ? import <nixpkgs> { },
}:
{
  # Packages with an actual source
  iio-hyprland = pkgs.callPackage ./iio-hyprland.nix { };
}
