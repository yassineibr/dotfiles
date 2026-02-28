{
  config,
  pkgs,
  lib,
  ...
}:
{
  networking.hostName = "gamma";

  imports = [
    ./hardware-configuration.nix

    ../common/optional/boot/systemd-boot.nix

    ../common/core
    ../common/core/home-manager.nix

    ./packages.nix

    # ../common/optional/network/tailscale.nix
    ../common/optional/network/netbird/client.nix

    ../common/optional/services/sshd.nix
    ../common/optional/hardware/prometheus/exporters

    ../common/optional/cache

    ../common/users/yassine

    ./wg-quick.nix
  ];

  # services.tailscale.useRoutingFeatures = "both";

  services.openssh.settings = {
    PasswordAuthentication = true;
  };

  system.stateVersion = "24.11";
}
