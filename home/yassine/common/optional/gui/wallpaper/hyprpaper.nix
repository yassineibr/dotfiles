{
  inputs,
  config,
  pkgs,
  ...
}:
{

  services.hyprpaper = {
    enable = true;
    package = inputs.hyprpaper.packages.${pkgs.stdenv.hostPlatform.system}.default;
    settings = {
      splash = true;

      preload = [ "${./images/nix-wallpaper.png}" ];

      wallpaper = [ ", ${./images/nix-wallpaper.png}" ];
    };
  };
}
