{
  inputs,
  pkgs,
  config,
  ...
}:
{
  # imports = [ inputs.hyprlock.homeManagerModules.default ];

  programs.hyprlock = {
    enable = true;
    settings = {

      backgrounds = [
        {
          path = "/home/yassine/.cache/lockscreen.png";
          blur_size = 8;
          blur_passes = 1;
        }
      ];
      labels = [ { text = "Hi $USER"; } ];
    };
  };
}
