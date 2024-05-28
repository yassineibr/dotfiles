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

      preloads = [ "${./images/nix-wallpaper.png}" ];

      wallpapers = [ ", ${./images/nix-wallpaper.png}" ];
    };
  };
}
