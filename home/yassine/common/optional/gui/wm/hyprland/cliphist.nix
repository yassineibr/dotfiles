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
  home.packages = with pkgs; [
    cliphist
  ];
  wayland.windowManager.hyprland = {
    settings = {
      # ---- exec-once (was `exec-once = [ ... ]`) -> hl.on("hyprland.start", fn) ----
      on = [
        {
          _args = [
            "hyprland.start"
            (lua ''
              function()
                hl.exec_cmd(${builtins.toJSON "wl-paste --type text --watch cliphist store"}) -- Stores only text data
                hl.exec_cmd(${builtins.toJSON "wl-paste --type image --watch cliphist store"}) -- Stores only image data
              end
            '')
          ];
        }
      ];

      # ---- keybind (was `bind = [ ... ]`) -> hl.bind(keys, dispatcher) ----
      bind = [
        {
          _args = [
            "SUPER + V"
            (lua "hl.dsp.exec_cmd(${builtins.toJSON "pkill rofi || cliphist list | rofi -dmenu | cliphist decode | wl-copy"})")
          ];
        }
      ];
    };
  };
}
