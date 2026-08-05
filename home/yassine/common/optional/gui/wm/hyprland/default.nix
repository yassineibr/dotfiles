{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
let
  mainMod = "SUPER";

  # `lib.generators.mkLuaInline` marks a string as a raw Lua expression
  # instead of a quoted Lua string literal. It's only needed for the
  # handful of places that need real Lua (dispatcher calls, closures) -
  # everything else below is a plain Nix value.
  lua = lib.generators.mkLuaInline;

  # keys: the bind's key combo, e.g. "${mainMod} + B"
  # dispatcher: raw Lua source for the dispatcher/closure, e.g. ''hl.dsp.window.close()''
  # opts: an options attrset (repeating/locked/mouse/...), or null
  mkBind = keys: dispatcher: opts: {
    _args = [
      keys
      (lua dispatcher)
    ]
    ++ lib.optional (opts != null) opts;
  };

  # shorthand for a plain shell exec dispatcher
  exec = cmd: "hl.dsp.exec_cmd(${builtins.toJSON cmd})";
in
{
  wayland.windowManager.hyprland.systemd.variables = [ "--all" ];
  imports = [
    # inputs.hyprland.homeManagerModules.default
    ./hyprlock.nix
    ./cliphist.nix
    # ./vms.nix
    ../../wallpaper/hyprpaper.nix
    ./tty-login.nix
    ../../launchers/rofi.nix
    ../../others/dunst.nix
    ../../others/wlogout
  ];
  home.packages = with pkgs; [
    xdg-utils
    nautilus
    playerctl
    grim
    wl-clipboard
    slurp
    upower
    (writeShellScriptBin "gamemode" ''
      # `hyprctl getoption` and `hyprctl reload` are generic hyprctl
      # subcommands and work the same regardless of config format.
      #
      # `hyprctl keyword SECTION:OPTION VALUE`, however, was the classic
      # hyprlang runtime-override mechanism and doesn't apply to a Lua
      # config root. The Lua-native equivalent is `hyprctl eval`, which
      # runs an arbitrary Lua expression against the live `hl` API - so
      # runtime overrides now go through `hl.config({...})` instead.
      HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
      if [ "$HYPRGAMEMODE" = "true" ] ; then
              hyprctl eval "hl.config({
                  animations = { enabled = false },
                  general = { gaps_in = 0, gaps_out = 0, border_size = 1 },
                  decoration = { blur = { enabled = false }, rounding = 0 },
              })"
              exit
          fi
          # Reloading re-executes hyprland.lua, restoring the normal settings.
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
    configType = "lua";
    # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
    package = null;
    portalPackage = null;

    settings = {
      # ---- env (was `env = [ ... ]`) -> hl.env(name, value) ----
      env = [
        {
          _args = [
            "WLR_DRM_NO_ATOMIC"
            "1"
          ];
        }
        {
          _args = [
            "QT_WAYLAND_DISABLE_WINDOWDECORATION"
            "1"
          ];
        }
        {
          _args = [
            "XDG_SESSION_TYPE"
            "wayland"
          ];
        }
        {
          _args = [
            "WLR_NO_HARDWARE_CURSORS"
            "1"
          ];
        }
        {
          _args = [
            "XCURSOR_SIZE"
            "24"
          ];
        }
        {
          _args = [
            "SSH_AUTH_SOCK"
            "/home/yassine/.bitwarden-ssh-agent.sock"
          ];
        }
        # { _args = [ "AQ_DRM_DEVICES" "/dev/dri/card0:/dev/dri/card1" ]; }
      ];

      # ---- exec-once (was `exec-once = [ ... ]`) -> hl.on("hyprland.start", fn) ----
      on = [
        {
          _args = [
            "hyprland.start"
            (lua ''
              function()
                hl.exec_cmd(${builtins.toJSON "brave"}, { workspace = "2 silent" })
                -- hl.exec_cmd(${builtins.toJSON "keepassxc"}, { workspace = "9 silent" })
                hl.exec_cmd(${builtins.toJSON "bitwarden"}, { workspace = "9 silent" })
                hl.exec_cmd(${builtins.toJSON "hyprctl setcursor ${config.home.pointerCursor.name} ${builtins.toString config.home.pointerCursor.size}"})
                hl.exec_cmd(${builtins.toJSON "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"})
                hl.exec_cmd(${builtins.toJSON "${pkgs.gnome-keyring}/bin/gnome-keyring-daemon --start --components=secrets"})
              end
            '')
          ];
        }
      ];

      # ---- monitors (was `monitor = [ ... ]`) -> hl.monitor({...}) ----
      monitor = [
        {
          output = "";
          mode = "preferred";
          position = "auto";
          scale = "auto";
        }
        {
          output = "Unknown-1";
          disabled = true;
        }
        # { output = "HDMI-A-1"; mode = "4096x2160@60"; position = "auto"; scale = 2; }
        # { output = "HDMI-A-1"; mode = "3840x2160@60"; position = "auto"; scale = "auto"; }
        # { output = "HDMI-A-1"; disabled = true; }
      ];

      # ---- everything that was a `hyprland.conf` variable/section ----
      # -> a single hl.config({...}) call, nested exactly like before.
      config = {
        ecosystem = {
          no_update_news = true;
        };

        cursor = {
          no_hardware_cursors = true;
        };

        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 2;
          "col.active_border" = {
            colors = [
              "rgba(33ccffee)"
              "rgba(00ff99ee)"
            ];
            angle = 45;
          };
          "col.inactive_border" = "rgba(595959aa)";
          layout = "dwindle";
          allow_tearing = false;
        };

        input = {
          kb_layout = "us,fr";
          kb_options = "compose:ralt,caps:escape,grp:alt_space_toggle";
          numlock_by_default = true;
          follow_mouse = 1;
          natural_scroll = false;
          touchpad = {
            natural_scroll = true;
          };
          sensitivity = 0;
        };

        decoration = {
          rounding = 10;
          blur = {
            enabled = false;
            size = 3;
            passes = 1;
          };
        };

        misc = {
          force_default_wallpaper = 0; # Set to 0 to disable the anime mascot wallpapers
          initial_workspace_tracking = 0;
          on_focus_under_fullscreen = 1;
        };

        animations = {
          enabled = true;
        };

        dwindle = {
          force_split = 2;
          preserve_split = true; # you probably want this
        };

        master = {
          new_status = "slave";
        };

        gestures = {
          workspace_swipe_distance = 200;
          workspace_swipe_cancel_ratio = 0.15;
        };

        xwayland = {
          force_zero_scaling = true;
        };
      };

      # ---- bezier curve (was `bezier = "myBezier, ..."`) -> hl.curve(name, def) ----
      curve = [
        {
          _args = [
            "myBezier"
            {
              type = "bezier";
              points = [
                [
                  0.05
                  0.9
                ]
                [
                  0.1
                  1.05
                ]
              ];
            }
          ];
        }
      ];

      # ---- animation list -> hl.animation({...}) ----
      animation = [
        {
          leaf = "windows";
          enabled = true;
          speed = 7;
          bezier = "myBezier";
        }
        {
          leaf = "windowsOut";
          enabled = true;
          speed = 7;
          bezier = "default";
          style = "popin 80%";
        }
        {
          leaf = "border";
          enabled = true;
          speed = 10;
          bezier = "default";
        }
        {
          leaf = "borderangle";
          enabled = true;
          speed = 8;
          bezier = "default";
        }
        {
          leaf = "fade";
          enabled = true;
          speed = 7;
          bezier = "default";
        }
        {
          leaf = "workspaces";
          enabled = true;
          speed = 6;
          bezier = "default";
        }
        # { leaf = "specialWorkspace"; enabled = true; speed = 4; bezier = "default"; style = "slidefadevert 20%"; }
        {
          leaf = "specialWorkspace";
          enabled = true;
          speed = 4;
          bezier = "default";
          style = "slidevert";
        }
      ];

      # ---- touchpad/trackpad gesture (was `gesture = [ "3, horizontal, workspace" ]`) ----
      gesture = [
        {
          fingers = 3;
          direction = "horizontal";
          action = "workspace";
        }
      ];

      # ---- workspace rules (was `workspace = [ ... ]`) -> hl.workspace_rule({...}) ----
      workspace_rule = [
        {
          workspace = "11";
          monitor = "HDMI-A-1";
        }
        {
          workspace = "special:socials";
          on_created_empty = "brave --profile-directory=Default --new-window discordapp.com/app web.whatsapp.com web.telegram.org";
          gaps_out = 25;
        }
        # { workspace = "special:work"; on_created_empty = "brave --new-window mail.google.com/mail/u/3/ trello.com/b/hTXY8u5O/pfe-2024-cloud-pentest"; gaps_out = 25; }
        {
          workspace = "special:work";
          on_created_empty = "brave --profile-directory='Profile 3'";
          gaps_out = 15;
        }
        {
          workspace = "special:music";
          on_created_empty = "spotify";
          gaps_out = 50;
        }
      ];

      # ---- window rules (was `windowrule = [ ... ]`, all commented out before) ----
      # window_rule = [
      #   { match.title = "^(Picture in picture)$"; float = true; }
      #   { match.title = "(Picture in picture)"; size = "624 351"; }
      #   { match.title = "^(Picture in picture)$"; pin = true; }
      #   { match.title = "(Picture in picture)"; move = "100%-w-5 100%-w-5"; }
      #   { match.title = "^(Firefox)$"; float = true; }
      #   { match.title = "(Firefox)"; size = "800 450"; }
      #   { match.title = "^(Firefox)$"; pin = true; }
      # ];

      # ---- keyboard "passthrough" toggle submap ----
      define_submap = [
        {
          _args = [
            "passthru"
            (lua ''
              function()
                hl.bind("${mainMod} + Escape", hl.dsp.submap("reset"))
              end
            '')
          ];
        }
      ];

      # ---- keybinds (was `bind`/`bindm`/`binde` = [ ... ]) ----
      bind = [
        (mkBind "${mainMod} + B" (exec "brave") null)
        (mkBind "${mainMod} + C" "hl.dsp.window.close()" null)
        (mkBind "${mainMod} + SHIFT + Q" "hl.dsp.exit()" null)
        (mkBind "${mainMod} + E" (exec "nautilus") null)
        (mkBind "${mainMod} + SHIFT + V" ''
          function()
            hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
            hl.dispatch(hl.dsp.window.pin({ action = "toggle" }))
          end
        '' null)
        (mkBind "${mainMod} + R" (exec "pkill rofi || rofi -show drun -show-icons") null)
        (mkBind "${mainMod} + SHIFT + R" (exec "pkill rofi || rofi -show run -show-icons") null)
        (mkBind "${mainMod} + SHIFT + C" (exec "pkill rofi || rofi -show ssh -show-icons") null)
        (mkBind "${mainMod} + P" (exec "pkill wlogout || wlogout --protocol layer-shell") null)
        (mkBind "${mainMod} + T" ''hl.dsp.layout("togglesplit")'' null) # dwindle
        (mkBind "${mainMod} + F" ''hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" })''
          null
        )
        (mkBind "${mainMod} + SHIFT + F"
          ''hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" })''
          null
        )

        # to switch between windows in a floating workspace
        (mkBind "ALT + Tab" ''
          function()
            hl.dispatch(hl.dsp.window.cycle_next())
            hl.dispatch(hl.dsp.window.bring_to_top())
          end
        '' null)
        (mkBind "${mainMod} + H" "hl.dsp.window.cycle_next({ next = false })" null)
        # (mkBind "${mainMod} + L" "hl.dsp.window.cycle_next()" null)
        # (mkBind "${mainMod} + J" "hl.dsp.window.resize({ x = -0.1 })" null)
        # (mkBind "${mainMod} + K" "hl.dsp.window.resize({ x = 0.1 })" null)

        # Example special workspace (scratchpad)
        (mkBind "${mainMod} + S" ''hl.dsp.workspace.toggle_special("magic")'' null)
        (mkBind "${mainMod} + SHIFT + S" ''hl.dsp.window.move({ workspace = "special:magic" })'' null)
        (mkBind "${mainMod} + M" ''hl.dsp.workspace.toggle_special("music")'' null)
        (mkBind "${mainMod} + SHIFT + M" ''hl.dsp.window.move({ workspace = "special:music" })'' null)
        (mkBind "${mainMod} + F1" ''hl.dsp.workspace.toggle_special("socials")'' null)
        (mkBind "${mainMod} + SHIFT + F1" ''hl.dsp.window.move({ workspace = "special:socials" })'' null)
        (mkBind "${mainMod} + F2" ''hl.dsp.workspace.toggle_special("work")'' null)
        (mkBind "${mainMod} + SHIFT + F2" ''hl.dsp.window.move({ workspace = "special:work" })'' null)

        # Scroll through existing workspaces with mainMod + scroll
        (mkBind "${mainMod} + mouse_down" ''hl.dsp.focus({ workspace = "e+1" })'' null)
        (mkBind "${mainMod} + mouse_up" ''hl.dsp.focus({ workspace = "e-1" })'' null)
        (mkBind "${mainMod} + Tab" ''hl.dsp.focus({ workspace = "e+1" })'' null)
        # (mkBind "${mainMod} + Tab" ''hl.dsp.focus({ workspace = "previous" })'' null)
        (mkBind "${mainMod} + SHIFT + space" ''hl.dsp.window.float({ action = "toggle" })'' null)
        # (mkBind "${mainMod} + SHIFT + F" ''hl.dsp.window.fullscreen({ mode = "fullscreen", action = "set" })'' null)
        # (mkBind "${mainMod} + Return" "hl.dsp.window.swap({ next = true })" null)

        # screenshot
        (mkBind "Print"
          (exec ''grim -g "$(slurp -w 0)" - | wl-copy -t image/png && wl-paste > $XDG_SCREENSHOTS_DIR/Screenshot-$(date +%F_%T).png | dunstify "Screenshot of the region taken" -t 1000'')
          null
        ) # screenshot of a region
        (mkBind "SHIFT + Print"
          (exec ''grim - | wl-copy -t image/png && wl-paste > $XDG_SCREENSHOTS_DIR/Screenshot-$(date +%F_%T).png | dunstify "Screenshot of whole screen taken" -t 1000'')
          null
        ) # screenshot of the whole screen

        # gamemode
        (mkBind "${mainMod} + G" (exec "gamemode") null)

        # Hyprlock
        (mkBind "${mainMod} + L" (exec "hyprlock") null)
        (mkBind "${mainMod} + SHIFT + L" (exec "systemctl suspend && hyprlock") null)

        (mkBind "${mainMod} + minus" ''hl.dsp.focus({ workspace = "11" })'' null)
        (mkBind "${mainMod} + SHIFT + minus" ''hl.dsp.window.move({ workspace = "11" })'' null)

        # Screen sharing
        # NOTE: `hyprctl keyword monitor ...` is the classic runtime-keyword
        # mechanism; kept unchanged here, but on a Lua root the more native
        # approach would be `hyprctl eval 'hl.monitor({...})'`.
        (mkBind "${mainMod} + bracketleft" (exec "hyprctl keyword monitor HDMI-A-1,preferred,auto,auto")
          null
        )
        (mkBind "${mainMod} + bracketright"
          (exec "hyprctl keyword monitor HDMI-A-1,preferred,auto,auto,mirror,eDP-1")
          null
        )

        # Monitor
        (mkBind "${mainMod} + D" ''hl.dsp.workspace.swap_monitors({ monitor1 = "1", monitor2 = "0" })''
          null
        )

        # Move/resize windows with mainMod + LMB/RMB and dragging
        (mkBind "${mainMod} + mouse:272" "hl.dsp.window.drag()" { mouse = true; })
        (mkBind "${mainMod} + mouse:273" "hl.dsp.window.resize()" { mouse = true; })

        # media / volume / brightness (repeating while held, like the old `binde`)
        (mkBind "XF86AudioRaiseVolume" (exec "wpctl set-volume -l 1.0 @DEFAULT_SINK@ 5%+") {
          repeating = true;
        })
        (mkBind "XF86AudioLowerVolume" (exec "wpctl set-volume -l 1.0 @DEFAULT_SINK@ 5%-") {
          repeating = true;
        })
        (mkBind "XF86AudioMute" (exec "wpctl set-mute @DEFAULT_SINK@ toggle") { repeating = true; })
        (mkBind "XF86AudioMicMute" (exec "wpctl set-mute @DEFAULT_SOURCE@ toggle") {
          repeating = true;
        })
        (mkBind "XF86MonBrightnessUp" (exec "brillo -u 150000 -A 5") { repeating = true; })
        (mkBind "XF86MonBrightnessDown" (exec "brillo -u 150000 -U 5") { repeating = true; })
        (mkBind "XF86AudioPlay" (exec "playerctl play-pause") { repeating = true; })
        (mkBind "XF86AudioNext" (exec "playerctl next") { repeating = true; })
        (mkBind "XF86AudioPrev" (exec "playerctl previous") { repeating = true; })

        # was `bindl = [ ]` (locked binds), currently unused:
        # (mkBind "switch:Lid Switch" (exec "systemctl suspend && swaylock") { locked = true; })

        # keyboard passthrough toggle
        (mkBind "${mainMod} + Escape" ''hl.dsp.submap("passthru")'' null)
      ]
      # workspaces
      # binds mainMod + [shift +] {1..10} to [move to] workspace {1..10}
      ++ (builtins.concatMap (
        i:
        let
          ws = toString i;
          key = toString (if i == 10 then 0 else i);
        in
        [
          (mkBind "${mainMod} + ${key}" ''hl.dsp.focus({ workspace = "${ws}" })'' null)
          (mkBind "${mainMod} + SHIFT + ${key}" ''hl.dsp.window.move({ workspace = "${ws}" })'' null)
        ]
      ) (lib.range 1 10));
    };
  };
}
