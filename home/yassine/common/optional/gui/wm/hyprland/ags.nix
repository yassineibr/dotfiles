{ ... }:
{
  imports = [ ../../ags ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = [ "ags -b hypr" ];

      bind = [
        # waybar
        "$mainMod, W, exec, ags -b hypr -r 'wallpaper.random()'" # Hide Waybar
      ];
    };
  };
}
