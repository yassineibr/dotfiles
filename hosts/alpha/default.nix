{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  networking.hostName = "alpha";

  imports = [
    ./hardware-configuration.nix
    ../common/optional/hardware/nvidia/laptop.nix
    ../common/optional/hardware/bluetooth.nix
    ../common/optional/firewall.nix

    ./packages.nix

    ../common/core
    ../common/optional/boot/secureboot.nix
    ../common/optional/boot/dualboot.nix
    ../common/optional/nixos-rebuild.nix

    ../common/optional/gui/hyprland.nix

    ../common/optional/pipewire.nix

    ../common/optional/network/network-manager.nix
    ../common/optional/network/tailscale.nix

    ../common/optional/virtualisation/virt-manager.nix
    ../common/optional/virtualisation/docker.nix

    ../common/optional/services/syncthing.nix
    ../common/optional/services/logind.nix
    ../common/optional/services/sshd.nix

    ../common/optional/fonts.nix

    ../common/users/yassine
    ../common/optional/health.nix

    ../common/optional/cache
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
