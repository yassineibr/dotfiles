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
}
