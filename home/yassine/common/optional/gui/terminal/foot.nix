{

  programs.foot = {
    enable = true;
    settings = {
      main = {
        term = "xterm-256color";

        # font = "Fira Code:size=11";
        dpi-aware = "yes";
        shell = "nu";
      };

      mouse = {
        hide-when-typing = "yes";
      };
    };
  };

  wayland.windowManager.hyprland = {
    settings = {
      workspace = [
        "special:magic, on-created-empty:foot, gapsout:50"
      ];
      bind = [
        "$mainMod, RETURN, exec, foot"
      ];
    };
  };
}
