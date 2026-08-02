{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
let
  lua = lib.generators.mkLuaInline;
in
{
  imports = [ ../../bars/waybar ];

  wayland.windowManager.hyprland = {
    settings = {
      # ---- exec-once (was `exec-once = [ ... ]`) -> hl.on("hyprland.start", fn) ----
      on = [
        {
          _args = [
            "config.reloaded"
            (lua ''
              function()
                hl.exec_cmd(${builtins.toJSON "pkill waybar; sleep 0.5 && waybar"})
              end
            '')
          ];
        }
      ];

      # ---- keybind (was `bind = [ ... ]`) -> hl.bind(keys, dispatcher) ----
      bind = [
        {
          _args = [
            "SUPER + W"
            (lua "hl.dsp.exec_cmd(${builtins.toJSON "pkill -SIGUSR1 waybar"})")
          ];
        }
      ];
    };
  };
}
