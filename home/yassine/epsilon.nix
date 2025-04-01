{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [ ./common/core ];

  home.stateVersion = "23.11";
}
