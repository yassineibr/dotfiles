{ ... }:
{
  imports = [ ../../ags ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = [ "ags -b hypr" ];

      # bind = [
      #   # waybar
      #   "$mainMod, W, exec, pkill -SIGUSR1 waybar" # Hide Waybar
      # ];
    };
  };
}
