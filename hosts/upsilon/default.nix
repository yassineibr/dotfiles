{
  config,
  pkgs,
  lib,
  inputs,
  modulesPath,
  ...
}:
{
  networking.hostName = "upsilon";

  imports = [
    inputs.disko.nixosModules.disko
    ./disk-config.nix
    ./hardware-configuration.nix
    ./packages.nix
    ./services

    # ../common/optional/boot/systemd-boot.nix

    ../common/core
    ../common/core/home-manager-unstable.nix

    ../common/optional/network/tailscale.nix
    ../common/optional/network/netbird/client.nix

    ../common/optional/services/sshd.nix
    ../common/optional/hardware/prometheus/exporters

    ../common/optional/virtualisation/docker.nix

    ../common/optional/cache

    ../common/users/yassine
  ];

  boot.loader.grub = {
    # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    # devices = "nodev";
    # efiSupport = true;
    # efiInstallAsRemovable = true;
  };

  services.tailscale.useRoutingFeatures = "both";

  services.openssh = {
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  boot.kernelParams = [ "console=ttyS0,19200n8" ];
  boot.loader.grub.extraConfig = ''
    serial --speed=19200 --unit=0 --word=8 --parity=no --stop=1;
    terminal_input serial;
    terminal_output serial
  '';

  system.stateVersion = "24.05";
}
