{
  config,
  pkgs,
  lib,
  ...
}: {
  services.syncthing = {
    enable = true;
    user = "yassine";
    dataDir = "/home/yassine/Documents/syncthing"; # Default folder for new synced folders
    configDir = "/home/yassine/.config/syncthing"; # Folder for Syncthing's settings and keys
  };

  networking.firewall.allowedTCPPorts = [8384 22000 4242 4243];
  networking.firewall.allowedUDPPorts = [22000 21027];
}
