{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
{
  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = [ pkgs.hplipWithPlugin ];
  };

  services.avahi.enable = true;
  services.avahi.nssmdns = true;

  # for a WiFi printer
  # services.avahi.openFirewall = true;
}
