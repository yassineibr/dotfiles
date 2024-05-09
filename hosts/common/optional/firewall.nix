{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
{
  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 1234 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  networking.nftables.enable = true;
}
