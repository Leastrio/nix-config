{
  inputs,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    configType = "lua";

    package = null;
    portalPackage = null;

    extraConfig = ''
      hl.monitor({
        output = "DP-1",
        mode = "2560x1440@170",
        position = "0x520",
        scale = "1",
        bitdepth = 10
      })

      hl.monitor({
        output = "HDMI-A-1",
        mode = "2560x1440@59",
        position = "2560x0",
        scale = "1",
        transform = 3,
        bitdepth = 10
      })

      hl.bind("SUPER + Return", hl.dsp.exec_cmd("ghostty"))
      hl.bind("SUPER + d", hl.dsp.exec_cmd("noctalia-shell ipc call launcher toggle"))
      hl.bind("SUPER + c", hl.dsp.window.close())
      hl.bind("SUPER + mouse:272", hl.dsp.window.drag())
      hl.bind("SUPER + mouse:273", hl.dsp.window.resize())
      hl.bind("Print", hl.dsp.exec_cmd("grimblast --notify copy area"))
      hl.bind("SUPER + f", hl.dsp.window.fullscreen())
      hl.bind("SUPER + v", hl.dsp.window.float({ action = "toggle"}))

      hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
      hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
      hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })

      hl.bind("SUPER + 1", hl.dsp.focus({ workspace = 1 }))
      hl.bind("SUPER + 2", hl.dsp.focus({ workspace = 2 }))
      hl.bind("SUPER + 3", hl.dsp.focus({ workspace = 3 }))
      hl.bind("SUPER + 4", hl.dsp.focus({ workspace = 4 }))
      hl.bind("SUPER + 5", hl.dsp.focus({ workspace = 5 }))
      hl.bind("SUPER + 6", hl.dsp.focus({ workspace = 6 }))

      hl.workspace_rule({
        workspace = "1",
        monitor = "DP-1",
        default = true,
      })
      hl.workspace_rule({
        workspace = "2",
        monitor = "HDMI-A-1",
        default = true,
      })
      hl.workspace_rule({
        workspace = "3",
        monitor = "DP-1",
      })
      hl.workspace_rule({
        workspace = "4",
        monitor = "HDMI-A-1",
      })
      hl.workspace_rule({
        workspace = "5",
        monitor = "DP-1",
      })
      hl.workspace_rule({
        workspace = "6",
        monitor = "HDMI-A-1",
      })

      hl.window_rule({
        match = {
          class = "Erlang",
        },
        center = true,
        float = true,
      })

      hl.env("HYPRCURSOR_THEME", "catppuccin-mocha-light-cursors")
      hl.env("HYPRCURSOR_SIZE", "24")
      hl.env("XCURSOR_SIZE", "24")

      hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
      hl.animation({
        leaf = "windows",
        enabled = true,
        speed = 7,
        bezier = "myBezier",
      })
      hl.animation({
        leaf = "windowsOut",
        enabled = true,
        speed = 7,
        bezier = "default",
        style = "popin 80%",
      })
      hl.animation({
        leaf = "border",
        enabled = true,
        speed = 10,
        bezier = "default",
      })
      hl.animation({
        leaf = "borderangle",
        enabled = true,
        speed = 8,
        bezier = "default",
      })
      hl.animation({
        leaf = "fade",
        enabled = true,
        speed = 7,
        bezier = "default",
      })
      hl.animation({
        leaf = "workspaces",
        enabled = true,
        speed = 6,
        bezier = "default",
      })

      hl.config({
        general = {
          gaps_out = 10,
        },
        cursor = {
          no_warps = true,
          no_hardware_cursors = true,
        },
        decoration = {
          rounding = 10,
          shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
          },
        },
        animations = {
          enabled = true,
        },
        ecosystem = {
          no_update_news = true,
        },
      })

      hl.on("hyprland.start", function()
        hl.exec_cmd("noctalia-shell")
        hl.exec_cmd("wl-paste --type text --watch cliphist store")
        hl.exec_cmd("wl-paste --type image --watch cliphist store")
        hl.exec_cmd("ghostty", { workspace = "1 silent" })
        hl.exec_cmd("firefox-devedition", { workspace = "2 silent" })
        hl.exec_cmd("vesktop", { workspace = "4 silent" })
        hl.exec_cmd("spotify", { workspace = "3 silent" })
      end)
    '';
  };
}
