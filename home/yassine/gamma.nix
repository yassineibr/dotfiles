{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [ ./common/core ];

  home.stateVersion = "24.11";
}
