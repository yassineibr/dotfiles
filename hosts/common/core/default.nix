{ outputs, ... }:
{
  # Importing all core files
  imports = [
    ./locale.nix
    ./sops.nix
    ./zsh.nix
    ./nix-settings.nix
    # ./home-manager.nix # Try including home-manager in the default.nix of each computer
    ./overlays.nix
  ];
}
