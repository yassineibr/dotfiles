{ pkgs, lib, ... }:
{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
    pkgs.gitMinimal
    pkgs.htop-vim
    pkgs.tmux
    pkgs.neovim
    pkgs.gdu
    pkgs.yazi
  ];
}
