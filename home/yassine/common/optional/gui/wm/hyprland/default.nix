{
  inputs,
  pkgs,
  config,
  ...
}:
{
  imports = [
    inputs.hyprland.homeManagerModules.default
    ./hyprlock.nix
    ./cliphist.nix
    # ./vms.nix
    ../../wallpaper/hyprpaper.nix
    ./tty-login.nix
    ../../launchers/rofi.nix
    ../../terminal/kitty.nix
    # ../../others/dunst.nix

    ../../others/wlogout
  ];

  home.packages = with pkgs; [
    xdg-utils
    gnome.nautilus
    playerctl
    grim
    wl-clipboard
    slurp
    upower
    (writeShellScriptBin "gamemode" ''
      HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
      if [ "$HYPRGAMEMODE" = 1 ] ; then
              hyprctl --batch "\
                  keyword animations:enabled 0;\
                  keyword decoration:drop_shadow 0;\
                  keyword decoration:blur:enabled 0;\
                  keyword general:gaps_in 0;\
                  keyword general:gaps_out 0;\
                  keyword general:border_size 1;\
                  keyword decoration:rounding 0"
              exit
          fi
          hyprctl reload
    '')
  ];

  # make stuff work on wayland
  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };

  wayland.windowManager.hyprland = {
    enable = true;
    # package = pkgs.unstable.hyprland;
    settings = {
      exec = [ ];
      exec-once = [
        "[workspace 2 silent] brave"
        "[workspace 9 silent] keepassxc"
        "hyprctl setcursor ${config.home.pointerCursor.name} ${builtins.toString config.home.pointerCursor.size}"
      ];

      env = [
        "WLR_DRM_NO_ATOMIC,1"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "XDG_SESSION_TYPE,wayland"
        "WLR_NO_HARDWARE_CURSORS,1"
        "XCURSOR_SIZE,24"
      ];
      monitor = [
        ",preferred,auto,auto"
        "Unknown-1,disable"
        # "HDMI-A-1,4096x2160@60,auto,2"
        # "HDMI-A-1,3840x2160@60,auto,auto"
        # "HDMI-A-1,disable"
      ];
      # monitor= "HDMI-A-1,preferred,auto,auto,mirror,eDP-1";

      general = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        layout = "dwindle";

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false;
      };
      input = {
        kb_layout = "us,fr";
        # kb_variant =
        # kb_model =
        kb_options = "compose:ralt,caps:escape,grp:alt_space_toggle";
        # kb_rules =
        numlock_by_default = true;

        follow_mouse = 1;

        natural_scroll = false;

        touchpad = {
          natural_scroll = true;
        };

        sensitivity = 0;
      };
      decoration = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        rounding = 10;

        blur = {
          enabled = false;
          size = 3;
          passes = 1;
        };

        drop_shadow = false;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      misc = {
        # disable_autoreload = true;
        force_default_wallpaper = 0; # Set to 0 to disable the anime mascot wallpapers
        # disable_hyprland_logo = true;
        # focus_on_activate = true;
        # vfr = true;
        # vrr = 1;
        initial_workspace_tracking = 0;
      };
      animations = {
        enabled = "yes";

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
          # "specialWorkspace, 1, 4, default, slidefadevert 20%"
          "specialWorkspace, 1, 4, default, slidevert"
        ];
      };

      dwindle = {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = "yes"; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        force_split = 2;
        preserve_split = "yes"; # you probably want this
      };

      master = {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        new_status = "slave";
      };

      gestures = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = "on";
        workspace_swipe_distance = 200;
        workspace_swipe_cancel_ratio = 0.15;
      };

      # "device:epic-mouse-v1" = {
      # sensitivity = -0.5;
      # };

      "$mainMod" = "SUPER";
      bind =
        [
          "$mainMod, RETURN, exec, kitty"
          "$mainMod, B, exec, brave"
          "$mainMod, C, killactive, "
          "$mainMod SHIFT, Q, exit, "
          "$mainMod, E, exec, nautilus"
          ''$mainMod SHIFT, V, exec, hyprctl --batch "dispatch togglefloating active; dispatch pin active" ''
          "$mainMod, R, exec, pkill rofi || rofi -show drun -show-icons"
          "$mainMod SHIFT, R, exec, pkill rofi || rofi -show run -show-icons"
          "$mainMod SHIFT, C, exec, pkill rofi || rofi -show ssh -show-icons"
          "$mainMod, P, exec, pkill wlogout || wlogout --protocol layer-shell"
          "$mainMod, T, togglesplit," # dwindle
          "$mainMod, F, fullscreen, 0"
          "$mainMod SHIFT, F, fullscreen, 1"
          # to switch between windows in a floating workspace
          "ALT,Tab,cyclenext,"
          "ALT,Tab,bringactivetotop,"

          "$mainMod, H, cyclenext, prev"
          "$mainMod, L, cyclenext,"
          "$mainMod, J, splitratio, -0.1"
          "$mainMod, K, splitratio, +0.1"

          # Example special workspace (scratchpad)
          "$mainMod, S, togglespecialworkspace, magic"
          "$mainMod SHIFT, S, movetoworkspace, special:magic"

          "$mainMod, M, togglespecialworkspace, music"
          "$mainMod SHIFT, M, movetoworkspace, special:music"

          "$mainMod, F1, togglespecialworkspace, socials"
          "$mainMod SHIFT, F1, movetoworkspace, special:socials"

          "$mainMod, F2, togglespecialworkspace, work"
          "$mainMod SHIFT, F2, movetoworkspace, special:work"

          # Scroll through existing workspaces with mainMod + scroll
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
          "$mainMod, TAB, workspace, e+1"

          # "$mainMod, Tab, workspace, previous"
          "$mainMod SHIFT, space, togglefloating, "
          "$mainMod SHIFT, F, fakefullscreen, "
          # "$mainMod, return, swapnext, "

          # screenshot
          ", Print, exec, grim -g \"$(slurp -w 0)\" - | wl-copy -t image/png && wl-paste > $XDG_SCREENSHOTS_DIR/Screenshot-$(date +%F_%T).png | dunstify \"Screenshot of the region taken\" -t 1000" # screenshot of a region
          "SHIFT, Print, exec, grim - | wl-copy -t image/png && wl-paste > $XDG_SCREENSHOTS_DIR/Screenshot-$(date +%F_%T).png | dunstify \"Screenshot of whole screen taken\" -t 1000" # screenshot of the whole screen

          #gamemode
          "$mainMod, G, exec, gamemode"

          # Hyprlock
          "$mainMod, L, exec, grim '/home/yassine/.cache/lockscreen.png' && hyprlock"
          "$mainMod SHIFT, L, exec, grim '/home/yassine/.cache/lockscreen.png' && systemctl suspend && hyprlock"
          "$mainMod, minus, workspace, 11"
          "$mainMod SHIFT, minus, movetoworkspace, 11"

          # Screen sharing
          "$mainMod,  bracketleft, exec, hyprctl keyword monitor HDMI-A-1,preferred,auto,auto"
          "$mainMod, bracketright, exec, hyprctl keyword monitor HDMI-A-1,preferred,auto,auto,mirror,eDP-1"
        ]
        ++ (
          # workspaces
          # binds $mainMod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (
            builtins.genList (
              x:
              let
                ws =
                  let
                    c = (x + 1) / 10;
                  in
                  builtins.toString (x + 1 - (c * 10));
              in
              [
                "$mainMod, ${ws}, workspace, ${toString (x + 1)}"
                "$mainMod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            ) 10
          )
        );

      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      binde = [
        ", xf86audioraisevolume, exec, wpctl set-volume -l 1.0 @DEFAULT_SINK@ 5%+"
        ", xf86audiolowervolume, exec, wpctl set-volume -l 1.0 @DEFAULT_SINK@ 5%-"
        ", xf86audiomute, exec, wpctl set-mute @DEFAULT_SINK@ toggle"

        ", xf86audiomicmute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle"

        ", xf86monbrightnessup, exec, brillo -u 150000 -A 5"
        ", xf86monbrightnessdown, exec, brillo -u 150000 -U 5"

        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      bindl = [
        # ", switch:Lid Switch, exec, systemctl suspend && swaylock"
      ];

      workspace = [
        "11,monitor:HDMI-A-1"
        "special:magic, on-created-empty:kitty, gapsout:50"
        "special:socials, on-created-empty:brave --new-window discordapp.com/app web.whatsapp.com web.telegram.org, gapsout:25"
        "special:work, on-created-empty:brave --new-window mail.google.com/mail/u/3/ trello.com/b/hTXY8u5O/pfe-2024-cloud-pentest, gapsout:25"
        "special:music, on-created-empty:spotify, gapsout:50"
      ];

      xwayland.force_zero_scaling = true;
    };
    extraConfig = ''
      bind = $mainMod,Escape,submap,passthru
      submap = passthru
      bind = $mainMod,Escape,submap,reset
      submap = reset
    '';
  };
}
