{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.netbird = {
    enable = true;
    clients.default = {
      autoStart = lib.mkDefault false;
    };
  };
}
