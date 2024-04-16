{
  pkgs,
  inputs,
  config,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

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
  };

  home-manager.users.yassine = import ../../../../home/yassine/${config.networking.hostName}.nix;
}
