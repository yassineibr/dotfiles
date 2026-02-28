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
      autoStart = lib.mkDefault true;
      interface = "nb0";
      port = 51880;
    };
  };
}
