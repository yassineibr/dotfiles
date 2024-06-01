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

      preload = [ "${./images/nix-wallpaper.png}" ];

      wallpaper = [ ", ${./images/nix-wallpaper.png}" ];
    };
  };
}
