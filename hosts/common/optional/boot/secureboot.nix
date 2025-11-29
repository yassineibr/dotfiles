{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
{
  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

  environment.systemPackages = [
    # For debugging and troubleshooting Secure Boot.
    pkgs.sbctl
  ];

  # Lanzaboote currently replaces the systemd-boot module.
  # This setting is usually set to true in configuration.nix
  # generated at installation time. So we force it to false
  # for now.
  #  boot.loader.systemd-boot.enable = true;
  # boot.loader.systemd-boot.edk2-uefi-shell.enable = true;
  # boot.loader.systemd-boot.windows = {
  # 	"11-pro" = {
  # 		title = "Windows 11";
  # 		efiDeviceHandle = "HD0b";
  # 	};
  # };

  boot.loader.systemd-boot.enable = lib.mkForce false;
  # boot.loader.timeout = 5;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
    settings = {
      timeout = 3;
      auto-firmware = false;
    };
  };

  ## Secure Boot
  boot.bootspec.enable = true;
}
