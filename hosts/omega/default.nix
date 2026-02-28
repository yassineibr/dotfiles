{ config, pkgs, ... }:
{
  networking.hostName = "omega"; # Define your hostname.

  imports = [
    ./hardware-configuration.nix
    ../common/optional/hardware/nvidia/desktop.nix
    ../common/optional/hardware/cross-compilation.nix
    ../common/optional/hardware/openrgb.nix
    ../common/optional/firewall.nix

    ./packages.nix

    ../common/core
    ../common/core/home-manager.nix

    ../common/optional/boot/grub.nix
    ../common/optional/boot/dualboot.nix
    ../common/optional/nixos-rebuild.nix

    ../common/optional/gui/hyprland.nix

    ../common/optional/pipewire.nix

    ../common/optional/network/network-manager.nix
    ../common/optional/network/tailscale.nix

    ../common/optional/virtualisation/virt-manager.nix
    ../common/optional/virtualisation/docker.nix

    ../common/optional/services/syncthing.nix
    ../common/optional/services/sshd.nix
    ../common/optional/services/sunshine.nix
    ../common/optional/services/autologin.nix

    ../common/optional/fonts.nix

    ../common/users/yassine
    ../common/optional/health.nix

    ../common/optional/cache

    ./wol.nix
  ];

  programs.nix-ld.enable = true;

  programs.steam.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
