{ ... }:
{
  imports = [ ../../bars/noctalia ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = [ "noctalia-shell" ];

      # bind = [
      #   # waybar
      #   "$mainMod, W, exec, pkill -SIGUSR1 waybar" # Hide Waybar
      # ];
    };
  };
}
