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
      interface = "nb0";
      port = 51880;
    };
  };
}
