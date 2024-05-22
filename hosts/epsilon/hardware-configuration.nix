{ pkgs, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
    initrd.availableKernelModules = [
      "xhci_pci"
      "usbhid"
      "usb_storage"
    ];
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  services.resolved.enable = true;
  networking.useNetworkd = true;
  networking.useDHCP = false;
  networking.interfaces.end0.useDHCP = true;

  networking.wireless.enable = false;

  hardware.enableRedistributableFirmware = true;
}
