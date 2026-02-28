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
      port = lib.mkForce 51880;
    };
  };
}
