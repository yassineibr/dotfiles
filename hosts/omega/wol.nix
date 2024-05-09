{
  config,
  lib,
  pkgs,
  ...
}:

let
  alx-kernel-module = config.boot.kernelPackages.callPackage ../../pkgs/alx/alx.nix { };
  patched = alx-kernel-module.overrideAttrs (prev: {
    patches = [ ../../pkgs/alx/linux-6.1.patch ];
  });
in
{
  networking.interfaces.enp3s0.wakeOnLan.enable = true;

  boot.extraModulePackages = [ (lib.hiPrio patched) ];
}
