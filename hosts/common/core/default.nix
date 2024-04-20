{outputs, ...}: {
  # Importing all core files
  imports = [
    ./locale.nix
    ./sops.nix
    ./zsh.nix
    ./nix-settings.nix
    ./home-manager.nix
    ./overlays.nix
  ];
}
