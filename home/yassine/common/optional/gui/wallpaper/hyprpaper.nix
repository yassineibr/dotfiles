{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [ inputs.hyprpaper.homeManagerModules.default ];

  services.hyprpaper = {
    enable = true;
    splash = true;

    preloads = [ "${./images/nix-wallpaper.png}" ];
    # preloads = [ "${config.stylix.image}" ];

    wallpapers = [ ", ${./images/nix-wallpaper.png}" ];
    # wallpapers = [ ", ${config.stylix.image}" ];
  };
}
