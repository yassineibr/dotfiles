{
  pkgs ? import <nixpkgs> { },
  inputs,
  ...
}:
{
  # Packages with an actual source
  iio-hyprland = pkgs.callPackage ./iio-hyprland.nix { };

  netbird = import ./netbird { inherit pkgs inputs; };
}
