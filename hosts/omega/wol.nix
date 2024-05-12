{
  config,
  lib,
  pkgs,
  ...
}:

let
  alx-pkm = config.boot.kernelPackages.callPackage ../../pkgs/alx/alx.nix { };
in
{
  networking.interfaces.enp3s0.wakeOnLan.enable = true;

  boot.extraModulePackages = [ (lib.hiPrio alx-pkm) ];
}
