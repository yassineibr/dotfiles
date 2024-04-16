{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  boot.plymouth.enable = true;
}
