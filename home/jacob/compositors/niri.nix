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

    spawn-at-startup "noctalia-shell"

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

    layout {
      background-color "transparent"
      focus-ring {
        width 2
        active-color "#b7bdf8"
        inactive-color "#505050"
      }
    }

    window-rule {
      draw-border-with-background false
      geometry-corner-radius 12
      clip-to-geometry true
    }

    layer-rule {
      match namespace="^noctalia-wallpaper*"
      place-within-backdrop true
    }

    binds {
      Mod+Return { spawn "ghostty"; }
      Mod+D repeat=false { spawn-sh "noctalia-shell ipc call launcher toggle"; }

      Mod+O repeat=false { toggle-overview; }
      Mod+C repeat=false { close-window; }

      Mod+Left  { focus-column-left; }
      Mod+Down  { focus-window-down; }
      Mod+Up    { focus-window-up; }
      Mod+Right { focus-column-right; }
      Mod+H     { focus-column-left; }
      Mod+J     { focus-window-down; }
      Mod+K     { focus-window-up; }
      Mod+L     { focus-column-right; }

      Mod+Ctrl+Left  { move-column-left; }
      Mod+Ctrl+Down  { move-window-down; }
      Mod+Ctrl+Up    { move-window-up; }
      Mod+Ctrl+Right { move-column-right; }
      Mod+Ctrl+H     { move-column-left; }
      Mod+Ctrl+J     { move-window-down; }
      Mod+Ctrl+K     { move-window-up; }
      Mod+Ctrl+L     { move-column-right; }

      Mod+1 { focus-workspace "1"; }
      Mod+2 { focus-workspace "2"; }
      Mod+3 { focus-workspace "3"; }
      Mod+4 { focus-workspace "4"; }
      Mod+5 { focus-workspace "5"; }
      Mod+6 { focus-workspace "6"; }
      Mod+Ctrl+1 { move-column-to-workspace "1"; }
      Mod+Ctrl+2 { move-column-to-workspace "2"; }
      Mod+Ctrl+3 { move-column-to-workspace "3"; }
      Mod+Ctrl+4 { move-column-to-workspace "4"; }
      Mod+Ctrl+5 { move-column-to-workspace "5"; }
      Mod+Ctrl+6 { move-column-to-workspace "6"; }

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
