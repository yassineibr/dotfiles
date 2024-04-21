{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./bash.nix
    ./eza.nix
    ./zoxide.nix
    ./zsh.nix
  ];

  home.username = "yassine";
  home.homeDirectory = "/home/${config.home.username}";

  nixpkgs.config.allowUnfree = true;
}
