{
  lib,
  pkgs,
  inputs,
  ...
}:
{
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "yassine" ];

  environment.etc."vbox/networks.conf".text = ''
    * 192.168.0.0/16
  '';
  environment.etc."ssl/openssl.cnf".text = ''
    openssl_conf = openssl_init

    [openssl_init]
    providers = provider_sect

    [provider_sect]
    default = default_sect
    legacy = legacy_sect    ######

    [default_sect]
    activate = 1

    [legacy_sect]           ######
    activate = 1            ######
  '';
  networking.firewall.interfaces.vboxnet0.allowedTCPPorts = [
    3389
    2222
    55986
    55985
    22
    5985
    5986
    53
  ];
  networking.firewall.interfaces.vboxnet0.allowedUDPPorts = [
    53
    67
    3389
    2222
    55986
    55985
    22
    5985
    5986
  ];
  networking.firewall.allowedTCPPorts = [
    3389
    2222
    55986
    55985
    22
    5985
    5986
  ];
  networking.firewall.allowedUDPPorts = [
    3389
    2222
    55986
    55985
    22
    5985
    5986
  ];
}
