{ lib, ... }:
let
  lua = lib.generators.mkLuaInline;
in
{
  imports = [ ../../bars/noctalia ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = [ ];
      # ---- exec-once (was `exec-once = [ ... ]`) -> hl.on("hyprland.start", fn) ----
      on = [
        {
          _args = [
            "hyprland.start"
            (lua ''
              function()
                hl.exec_cmd(${builtins.toJSON "noctalia-shell || noctalia"})
              end
            '')
          ];
        }
      ];

      # bind = [
      #   # waybar
      #   "$mainMod, W, exec, pkill -SIGUSR1 waybar" # Hide Waybar
      # ];
    };
  };
}
