{
  lib,
  pkgs,
  inputs,
  ...
}: {
  virtualisation.libvirtd = {
    enable = true;
    qemu.ovmf.enable = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
  };
  programs.virt-manager.enable = true;

  # Allow dhcp req from libvirt guests
  networking.firewall.interfaces = lib.lists.foldr (a: b: a // b) {} (builtins.map (x: {
      ${x} = {
        allowedTCPPorts = [53];
        allowedUDPPorts = [53 67];
      };
    }) [
      "virbr0"
      "virbr2"
      "virbr3"
      "virbr4"
    ]);
}
