{
  pkgs,
  inputs,
  config,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
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
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEqgfTS1lt6os0E7w9iyClSvlXSapzQBtIV9wyI9gnK1 yassine@beta"
    ];
  };

  home-manager.users.yassine = import ../../../../home/yassine/${config.networking.hostName}.nix;
}
