{
  inputs,
  pkgs,
  config,
  ...
}:
{
  home.packages = [ pkgs.cliphist ];

  wayland.windowManager.hyprland = {
    settings = {
      exec-once = [
        "wl-paste --type text --watch cliphist store #Stores only text data"
        "wl-paste --type image --watch cliphist store #Stores only image data"
      ];
      bind = [
        ''SUPER, V, exec, pkill rofi || cliphist list | rofi -dmenu | cliphist decode | wl-copy''
      ];
    };
  };
}
