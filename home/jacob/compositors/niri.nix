{
  inputs,
  pkgs,
  ...
}: {
  xdg.configFile."niri/config.kdl".text = ''
    prefer-no-csd
    screenshot-path null

    hotkey-overlay {
      skip-at-startup
    }
      
    input {
      focus-follows-mouse max-scroll-amount="10%"
      disable-power-key-handling
    }

    spawn-at-startup "noctalia"

    output "DP-1" {
      mode "2560x1440@170"
      position x=0 y=520
      hot-corners {
        off
      }
    } 

    output "HDMI-A-1" {
      mode "2560x1440@59"
      position x=2560 y=0
      transform "270"

      layout {
        default-column-width { proportion 1.0; }
      }

      hot-corners {
        off
      }
    }

    output "DP-2" {
      mode "2560x1600@120"
      position x=480 y=1960
      hot-corners {
        off
      }
    }

    layout {
      background-color "transparent"
      focus-ring {
        width 2
        active-color "#b7bdf8"
        inactive-color "#505050"
      }
      default-column-width { proportion 0.5; }
    }

    window-rule {
      draw-border-with-background false
      geometry-corner-radius 12
      clip-to-geometry true
    }

    window-rule {
      match app-id="dev.noctalia.Noctalia"
      open-floating true
      default-column-width { fixed 1080; }
      default-window-height { fixed 920; }
    }

    layer-rule {
      match namespace="^noctalia-wallpaper"
      place-within-backdrop true
    }

    binds {
      Mod+Return { spawn "ghostty"; }
      Mod+D repeat=false { spawn-sh "noctalia msg panel-toggle launcher"; }

      Mod+O repeat=false { toggle-overview; }
      Mod+C repeat=false { close-window; }

      Mod+Left  { focus-column-left; }
      Mod+Down  { focus-window-down; }
      Mod+Up    { focus-window-up; }
      Mod+Right { focus-column-right; }

      Mod+Ctrl+Left  { move-column-left; }
      Mod+Ctrl+Down  { move-window-down; }
      Mod+Ctrl+Up    { move-window-up; }
      Mod+Ctrl+Right { move-column-right; }

      Mod+WheelScrollDown cooldown-ms=150 { focus-column-right; }
      Mod+WheelScrollUp { focus-column-left; }

      Mod+1 { focus-workspace 1; }
      Mod+2 { focus-workspace 2; }
      Mod+3 { focus-workspace 3; }
      Mod+4 { focus-workspace 4; }
      Mod+5 { focus-workspace 5; }
      Mod+6 { focus-workspace 6; }
      Mod+Ctrl+1 { move-column-to-workspace 1; }
      Mod+Ctrl+2 { move-column-to-workspace 2; }
      Mod+Ctrl+3 { move-column-to-workspace 3; }
      Mod+Ctrl+4 { move-column-to-workspace 4; }
      Mod+Ctrl+5 { move-column-to-workspace 5; }
      Mod+Ctrl+6 { move-column-to-workspace 6; }

      Mod+F { maximize-column; }
      Mod+Shift+F { fullscreen-window; }
      Mod+Ctrl+F { expand-column-to-available-width; }

      Mod+Shift+C { center-column; }
      Mod+V { toggle-window-floating; }

      Print { screenshot; }
      XF86AudioPlay        allow-when-locked=true { spawn-sh "playerctl play-pause"; }
      XF86AudioPause       allow-when-locked=true { spawn-sh "playerctl play-pause"; }
      XF86AudioStop        allow-when-locked=true { spawn-sh "playerctl stop"; }
      XF86AudioPrev        allow-when-locked=true { spawn-sh "playerctl previous"; }
      XF86AudioNext        allow-when-locked=true { spawn-sh "playerctl next"; }
    }
  '';
}
