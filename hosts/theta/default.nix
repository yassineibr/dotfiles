{
  config,
  pkgs,
  lib,
  ...
}:
{
  networking.hostName = "theta";

  imports = [
    ./hardware-configuration.nix

    ../common/optional/boot/systemd-boot.nix

    ../common/core
    ../common/core/home-manager.nix

    ./packages.nix

    ../common/optional/network/netbird/client.nix

    ../common/optional/services/sshd.nix
    ../common/optional/hardware/prometheus/exporters

    ../common/optional/virtualisation/docker.nix

    ../common/optional/cache

    ../common/users/yassine

    # ./wg-quick.nix
  ];

  services.netbird.clients.default.autoStart = true;

  services.openssh.settings = {
    PasswordAuthentication = true;
  };

  system.stateVersion = "25.11";
}
