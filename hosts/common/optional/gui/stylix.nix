{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [ inputs.stylix.nixosModules.stylix ];

  stylix.enable = true;

  #  stylix.image = pkgs.fetchurl {
  #   url = "https://www.pixelstalk.net/wp-content/uploads/images9/8K-Summer-Desktop-Wallpaper-featuring-a-palm-fringed-beach-against-a-backdrop-of-azure-skies-and-fluffy-white-clouds.jpg";
  #   sha256 = "sha256-gI05MDPq0f0UDkzBl01N32jEPnRhRmWQUgCOEKylGZk=";
  # };

  stylix.image = lib.mkDefault ./wallpaper/dark-mountain.jpg;
  stylix.polarity = lib.mkDefault "either";

  stylix.cursor.package = pkgs.bibata-cursors;
  stylix.cursor.name = "Bibata-Modern-Ice";
  stylix.cursor.size = 24;

  specialisation = {
    dark.configuration = {
      stylix.image = ./wallpaper/dark-mountain.jpg;
      stylix.polarity = "dark";
    };
    light.configuration = {
      stylix.image = ./wallpaper/light-beach.jpg;
      stylix.polarity = "light";
    };
  };

  stylix.fonts.sizes = {
    applications = 12;
    terminal = 12;
    desktop = 10;
    popups = 10;
  };

  stylix.opacity = {
    applications = 1.0;
    terminal = 1.0;
    desktop = 1.0;
    popups = 1.0;
  };

  stylix.fonts = {
    monospace = {
      package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
      name = "JetBrainsMono Nerd Font Mono";
    };
    sansSerif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
    };
    serif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Serif";
    };
  };

}
