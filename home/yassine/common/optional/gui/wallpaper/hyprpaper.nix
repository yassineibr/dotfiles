{
  inputs,
  config,
  pkgs,
  ...
}:
{
  # imports = [ inputs.hyprpaper.homeManagerModules.default ];

  services.hyprpaper = {
    enable = true;
    settings = {
      splash = true;

      preload = [ "${config.stylix.image}" ];

      wallpaper = [ ", ${config.stylix.image}" ];
    };
  };
}
