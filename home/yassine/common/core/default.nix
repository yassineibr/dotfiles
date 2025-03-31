{ config, pkgs, ... }:
{
  imports = [
    ./bash.nix
    ./eza.nix
    ./zoxide.nix
    ./zsh.nix
    ./sops.nix
    ./nix.nix
  ];

  home.username = "yassine";
  home.homeDirectory = "/home/${config.home.username}";

  # nixpkgs.config.allowUnfree = true;
}
