{ inputs, pkgs, ... }:
{
  # Importing all core files
  imports = [
    inputs.stylix.nixosModules.stylix
    ./locale.nix
    ./sops.nix
    ./zsh.nix
    ./nix-settings.nix
    ./home-manager.nix
    ./overlays.nix
  ];

  stylix.image = pkgs.fetchurl {
    url = "https://www.pixelstalk.net/wp-content/uploads/2016/05/Epic-Anime-Awesome-Wallpapers.jpg";
    sha256 = "enQo3wqhgf0FEPHj2coOCvo7DuZv+x5rL/WIo4qPI50=";
  };

  stylix.polarity = "dark";

}
