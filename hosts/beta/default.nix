{
  config,
  pkgs,
  ...
}:
{
  networking.hostName = "beta"; # Define your hostname.

  imports = [
    ./hardware-configuration.nix
    ./packages.nix

    ../common/core
    ../common/optional/boot/systemd-boot.nix
    ../common/optional/nixos-rebuild.nix

    # ./gnome.nix
    ../common/optional/gui/hyprland.nix

    ../common/optional/pipewire.nix

    ../common/optional/virtualisation/virt-manager.nix
    ../common/optional/virtualisation/docker.nix
    # ../common/optional/virtualisation/podman.nix

    ../common/optional/network/network-manager.nix
    ../common/optional/network/tailscale.nix
    ../common/optional/network/netbird/client.nix

    ../common/optional/fonts.nix

    ../common/users/yassine

    ../common/optional/cache
    ../common/optional/services/sshd.nix
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # hardware.opengl.driSupport = true;

  networking.firewall.enable = false;
  services.fwupd.enable = true;

  programs.gnupg.agent.pinentryPackage = pkgs.pinentry-qt;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
