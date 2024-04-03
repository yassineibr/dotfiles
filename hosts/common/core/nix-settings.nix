{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  # nix Flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 7d";
  };

  nix.registry =
    (lib.mapAttrs (_: flake: {inherit flake;}))
    ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  nix.settings.auto-optimise-store = true;

  nix.settings.trusted-users = ["root" "@wheel"];

  # Sync the nixpkgs Input Between nix-build / nix build and nix-shell/ nix shell
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
}
