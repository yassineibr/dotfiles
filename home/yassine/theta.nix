{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./common/core
    ./common/core/nushell.nix

    ./common/optional/apps/nvim.nix

    ./common/optional/apps/direnv.nix
  ];

  home.stateVersion = "25.11";
}
