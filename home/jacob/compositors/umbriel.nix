{pkgs, ...}: let
  toml = pkgs.formats.toml {};

  workspaces = ["1" "2" "3" "4" "5" "6"];

  startupApp = appId: workspace: output: {
    match = {
      app_id = appId;
      at_startup = true;
    };
    default_workspace = workspace;
    default_output = output;
  };

  settings = {
    general = {
      autostart = [
        "noctalia"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "ghostty"
        "firefox-devedition"
        "spotify"
        "vesktop"
      ];
    };

    output = {
      DP-1 = {
        mode = "2560x1440@170";
        position = [0 520];
        bit_depth = 10;
        workspaces = ["1" "3" "5"];
        focus_at_startup = true;
      };
      HDMI-A-1 = {
        mode = "2560x1440@59";
        position = [2560 0];
        transform = "270";
        bit_depth = 10;
        workspaces = ["2" "4" "6"];
        layout.scrolling.default_extent_fraction = 1.0;
      };
      DP-2 = {
        mode = "2560x1600@120";
        position = [480 1960];
        scale = 1.6;
        bit_depth = 10;
      };
    };

    layout = {
      mode = "dwindle";
      gap = 10;
      extent_presets = [0.333 0.5 0.667];
      scrolling = {
        default_extent_fraction = 0.5;
        center_focused = "on_overflow";
      };
    };

    workspace = map (name: {
      inherit name;
      layout.mode = "scrolling";
    }) ["3" "4" "5" "6"];

    appearance = {
      border_width = 2;
      corner_radius = 10;
      blur.radius = 3;
    };

    colors.border = {
      focused = "#B7BDF8FF";
      unfocused = "#505050FF";
    };

    input.focus.follows_mouse = true;

    keybinds =
      {
        "Mod+Return" = {
          action = "spawn ghostty";
          repeat = false;
        };
        "Mod+D" = {
          action = "spawn noctalia msg panel-toggle launcher";
          repeat = false;
        };
        "Mod+C" = {
          action = "window-close";
          repeat = false;
        };
        "Mod+F" = {
          action = "window-toggle-fullscreen";
          repeat = false;
        };
        "Mod+V" = {
          action = "window-toggle-floating";
          repeat = false;
        };
        "Print" = "spawn grimblast --notify copy area";
        "Mod+Escape" = "session-quit";

        "XF86AudioPlay" = {
          action = "spawn playerctl play-pause";
          allow_when_locked = true;
          repeat = false;
        };
        "XF86AudioPrev" = {
          action = "spawn playerctl previous";
          allow_when_locked = true;
        };
        "XF86AudioNext" = {
          action = "spawn playerctl next";
          allow_when_locked = true;
        };
        "XF86AudioRaiseVolume" = {
          action = "spawn noctalia msg volume-up";
          allow_when_locked = true;
        };
        "XF86AudioLowerVolume" = {
          action = "spawn noctalia msg volume-down";
          allow_when_locked = true;
        };
        "XF86AudioMute" = {
          action = "spawn noctalia msg volume-mute";
          allow_when_locked = true;
          repeat = false;
        };

        "Mod+Left" = "window-focus-left";
        "Mod+Down" = "window-focus-down";
        "Mod+Up" = "window-focus-up";
        "Mod+Right" = "window-focus-right";
        "Mod+Ctrl+Left" = "column-move-left";
        "Mod+Ctrl+Down" = "window-move-down";
        "Mod+Ctrl+Up" = "window-move-up";
        "Mod+Ctrl+Right" = "column-move-right";
        "Mod+WheelUp" = "window-focus-left";
        "Mod+WheelDown" = "window-focus-right";
        "Mod+O" = {
          action = "overview-toggle";
          repeat = false;
        };
        "Mod+Ctrl+F" = {
          action = "window-toggle-maximize";
          repeat = false;
        };
        "Mod+Shift+C" = "column-center";

        "Mod+R" = "window-cycle-primary-extent";
        "Mod+Shift+R" = "window-cycle-primary-extent-back";
        "Mod+BracketLeft" = "window-consume-left";
        "Mod+BracketRight" = "window-consume-right";
        "Mod+W" = {
          action = "column-toggle-tabbed";
          repeat = false;
        };

        "Mod+S" = "layout-toggle-split";
      }
      // builtins.listToAttrs (map (ws: {
          name = "Mod+${ws}";
          value = "workspace-switch --name ${ws}";
        })
        workspaces)
      // builtins.listToAttrs (map (ws: {
          name = "Mod+Ctrl+${ws}";
          value = "window-move-to-workspace --name ${ws}";
        })
        workspaces);

    window_rule = [
      {blur = true;}
      {
        match.app_id = "^dev.noctalia.Noctalia$";
        default_floating = true;
        default_floating_size_px = {
          width = 1080;
          height = 920;
        };
      }
      {
        match.app_id = "^dev.noctalia.UmbrielSharePicker$";
        default_floating = true;
      }
      {
        match.app_id = "^Erlang$";
        default_floating = true;
      }
      (startupApp "^com.mitchellh.ghostty$" "1" "DP-1")
      (startupApp "^firefox" "2" "HDMI-A-1")
      (startupApp "^[Ss]potify$" "3" "DP-1")
      (startupApp "^vesktop$" "4" "HDMI-A-1")
    ];

    layer_rule = [
      {
        match.namespace = "^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd|desktop-widget-[^\"]*)$";
        blur = true;
        blur_ignore_alpha = 0.5;
        blur_popups = true;
      }
    ];
  };
in {
  xdg.configFile."umbriel/config.toml".source = toml.generate "umbriel-config.toml" settings;
}
