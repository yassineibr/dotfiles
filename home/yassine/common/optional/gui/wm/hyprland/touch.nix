{ pkgs, inputs, ... }:
{
  wayland.windowManager.hyprland = {
    plugins = [ inputs.hyprgrass.packages.${pkgs.system}.default ];

    settings = {
      "plugin:touch_gestures" = {
        # The default sensitivity is probably too low on tablet screens,
        # I recommend turning it up to 4.0
        sensitivity = 1.0;

        # must be >= 3
        workspace_swipe_fingers = 3;

        # switching workspaces by swiping from an edge, this is separate from workspace_swipe_fingers
        # and can be used at the same time
        # possible values: l, r, u, or d
        # to disable it set it to anything else
        workspace_swipe_edge = "d";

        # in milliseconds
        long_press_delay = 400;

        experimental = {
          # send proper cancel events to windows instead of hacky touch_up events,
          # NOT recommended as it crashed a few times, once it's stabilized I'll make it the default
          send_cancel = 0;
        };
      };
    };
  };
}
