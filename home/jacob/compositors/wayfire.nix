{ 
  pkgs,
  ...
}: {
  wayland.windowManager.wayfire = {
    enable = true;
    plugins = with pkgs.wayfirePlugins; [ wayfire-plugins-extra ];
    settings = {
      core = {
        plugins = "animate autostart command cube decoration fisheye foreign-toplevel grid gtk-shell move place resize switcher wm-actions wobbly wrot annotate follow-focus water";
        close_top_view = "<super> KEY_C";
      };

      "output:DP-1" = {
        mode = "2560x1440@170";
        position = "0,520";
        transform = "normal";
        scale = 1.0;
      };

      "output:HDMI-A-1" = {
        mode = "2560x1440@59";
        position = "2560x0";
        transform = "270";
        scale = 1.0;
      };

      animate = {
        open_animation = "zoom";
        close_animation = "fire";
      };

      decoration.ignore_views = "all";
      
      autostart = {
        autostart_wf_shell = false;
        noctalia = "noctalia-shell";
      };

      command = {
        binding_terminal = "<super> KEY_ENTER";
        command_terminal = "ghostty";

        binding_launcher = "<super> KEY_D";
        command_launcher = "noctalia-shell ipc call launcher toggle";
      };

      move.activate = "<super> BTN_LEFT";
      resize.activate = "<super> BTN_RIGHT";
      wrot.activate = "<super> <ctrl> BTN_RIGHT";
      water.activate = "<super> <ctrl> BTN_LEFT";
      fisheye.activate = "<super> <ctrl> KEY_F";
      switcher = {
        next_view = "<super> KEY_TAB";
        prev_view = "<super> <shift> KEY_TAB";
      };
      cube.activate = "<ctrl> <alt> BTN_LEFT";

    };
  };
}
