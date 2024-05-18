{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [ ./common/core ];

  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "23.11";
}
