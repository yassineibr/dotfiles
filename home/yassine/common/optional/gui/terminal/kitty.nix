{
  lib,
  ...
}:
let
  lua = lib.generators.mkLuaInline;
in
{
  programs.kitty = {
    enable = true;
    shellIntegration.enableBashIntegration = true;
    shellIntegration.enableZshIntegration = true;

    extraConfig = "background_opacity 0.85";
    font = {
      name = "JetBrainsMono Bold";
      size = 12;
    };
    settings = {
      shell = "nu";
    };
  };

  wayland.windowManager.hyprland = {
    settings = {
      # ---- workspace rule (was `workspace = [ ... ]`) -> hl.workspace_rule({...}) ----
      workspace_rule = [
        {
          workspace = "special:magic";
          on_created_empty = "kitty";
          gaps_out = 50;
        }
      ];

      # ---- keybind (was `bind = [ ... ]`) -> hl.bind(keys, dispatcher) ----
      bind = [
        {
          _args = [
            "SUPER + RETURN"
            (lua "hl.dsp.exec_cmd(${builtins.toJSON "kitty"})")
          ];
        }
      ];
    };
  };
}
