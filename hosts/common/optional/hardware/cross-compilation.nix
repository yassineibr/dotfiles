{ pkgs, ... }:
{
  # Cross compilation
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
}
