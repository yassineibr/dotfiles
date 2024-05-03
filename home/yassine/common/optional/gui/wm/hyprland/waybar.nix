{...}: {
  imports = [
    ../../bars/waybar
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec = [
        "pkill waybar; sleep 0.5 && waybar"
      ];

      bind = [
        # waybar
        "$mainMod, W, exec, pkill -SIGUSR1 waybar" # Hide Waybar
      ];
    };
  };
}
