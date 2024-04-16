{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./common/core

    ./common/optional/apps/git.nix
    ./common/optional/apps/direnv.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "23.11";
}
