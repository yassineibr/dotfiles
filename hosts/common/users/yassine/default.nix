{ pkgs, config, ... }:
let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users.mutableUsers = false;
  users.users.yassine = {
    isNormalUser = true;
    description = "yassine";
    shell = pkgs.zsh;
    extraGroups =
      [
        "video"
        "wheel"
      ]
      ++ ifTheyExist [
        "docker"
        "networkmanager"
        "libvirtd"
        "vboxusers"
      ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEqgfTS1lt6os0E7w9iyClSvlXSapzQBtIV9wyI9gnK1 yassine"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIItiOURWobhCmj8SErugcEBJyhSd7V1Eqcm4u8wptfRY yassine"
    ];
    hashedPasswordFile = config.sops.secrets.yassine-password.path;
  };

  sops.secrets.yassine-password = {
    sopsFile = ../../secrets.yml;
    neededForUsers = true;
  };

  home-manager.users.yassine = import ../../../../home/yassine/${config.networking.hostName}.nix;
}
