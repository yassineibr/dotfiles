{...}: {
  imports = [
    ../../bars/eww
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec = [
        "pkill eww; sleep 0.5 && eww open bar"
      ];

      bind = [
        # Eww
        "$mainMod, W, exec, eww open bar --toggle" # Hide Waybar
      ];
    };
  };
}
