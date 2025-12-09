{
  config,
  pkgs,
  inputs,
  outputs,
  lib,
  ...
}:
{
  hardware.opentabletdriver.enable = true;

  networking.hostName = "alpha";

  imports = [
    ./hardware-configuration.nix
    ../common/optional/hardware/nvidia/laptop.nix
    # ../common/optional/hardware/pcie-vfio.nix
    ../common/optional/hardware/bluetooth.nix
    ../common/optional/hardware/cross-compilation.nix
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
    ../common/optional/network/netbird/client.nix

    ../common/optional/virtualisation/virt-manager.nix
    ../common/optional/virtualisation/docker.nix
    # ../common/optional/virtualisation/podman.nix

    ../common/optional/services/syncthing.nix
    ../common/optional/services/logind.nix
    ../common/optional/services/sshd.nix
    ../common/optional/gpg.nix

    ../common/optional/fonts.nix

    ../common/users/yassine
    ../common/optional/health.nix

    ../common/optional/cache
  ];

  programs.nix-ld.enable = true;
  networking.firewall.enable = false;
  virtualisation.docker.daemon.settings = {
    data-root = "/home/docker/docker";
  };

  services.netbird.clients.default.autoStart = true;

  programs.gnupg.agent.pinentryPackage = pkgs.pinentry-qt;

  boot = {

    plymouth = {
      enable = true;
      theme = "rings";
      themePackages = with pkgs; [
        # By default we would install all themes
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "rings" ];
        })
      ];
    };

    # Enable "Silent Boot"
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
    # Hide the OS choice for bootloaders.
    # It's still possible to open the bootloader list by pressing any key
    # It will just not appear on screen unless a key is pressed
    loader.timeout = 0;

  };

  # security.pam.services.kwallet = {
  # 	name = "kwallet";
  # 	enableKwallet = true;
  # };

  # virtualisation.vmware.host.enable = true;

  programs.steam.enable = true;

	virtualisation.waydroid.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
