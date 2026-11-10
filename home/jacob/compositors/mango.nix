{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.mango.hmModules.mango
  ];

  wayland.windowManager.mango = {
    enable = true;
    package = pkgs.mango;

    settings = {
      monitor_rule = [
        "name:^DP-1$,width:2560,height:1440,refresh:170,x:0,y:520,primary:1"
        "name:^HDMI-A-1$,width:2560,height:1440,refresh:59,x:2560,y:0,rr:3"
        "name:^DP-2$,width:2560,height:1600,refresh:120,x:480,y:1960,scale:1.6"
      ];

      exec_once = [
        "noctalia"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "firefox-devedition"
        "spotify"
        "vesktop"
      ];
      
      window_rule_once = [
        "tags:1,monitor:DP-1,app_id:^firefox"
        "tags:1,monitor:DP-2,app_id:^[Ss]potify$"
        "tags:1,monitor:HDMI-A-1,app_id:^vesktop$"
      ];

      window_rule = [
        "is_floating:1,width:1080,height:920,app_id:^dev.noctalia.Noctalia$"
        "is_floating:1,app_id:^Erlang$"
      ];

      tag_rule = 
        (map (tag: 
          "id:${tag},monitor_name:DP-1,layout_name:dwindle"
        ) ["1" "2" "3"])
        ++ [
          "id:1,monitor_name:HDMI-A-1,layout_name:vertical_scroller"
          "id:1,monitor_name:DP-2,layout_name:scroller"
        ];

      scroller_default_proportion = 0.99;
      scroller_ignore_proportion_single = 0;
      scroller_default_proportion_single = 1.0;
      scroller_prefer_overspread = 0;
      scroller_structs = 10;

      border_px = 2;
      border_radius = 10;

      root_color = "0x1e1e2eff";
      shadows_color = "0x11111b99";
      border_color = "0x45475aff";
      drop_color = "0xf5c2e780";
      split_color = "0xfab387ff";
      focus_color = "0xcba6f7ff";
      maximized_screen_color = "0xa6e3a1ff";
      urgent_color = "0xf38ba8ff";
      global_color = "0x89b4faff";
      overlay_color = "0x94e2d5ff";
      jump_label_decorate_fg_color = "0xcba6f7ff";
      jump_label_decorate_bg_color = "0x313244ff";
      jump_label_decorate_focus_fg_color = "0x1e1e2eff";
      jump_label_decorate_focus_bg_color = "0xcba6f7ff";
      jump_label_decorate_border_color = "0xcba6f7ff";

      gap_inner_horizontal = 10;
      gap_inner_vertical = 10;
      gap_outer_horizontal = 10;
      gap_outer_vertical = 10;

      shadows = 1;
      shadows_size = 4;
      shadows_blur = 15;
      layer_shadows = 0;

      blur = 1;
      blur_layer = 0;

      animations = 1;
      layer_animations = 0;
      animation_curve_move = "0.46,1,0.29,0.99";
      animation_curve_open = "0.46,1,0.29,0.99";
      animation_curve_tag = "0.46,1,0.29,0.99";
      animation_curve_close = "0.46,1,0.29,0.99";
      animation_curve_focus = "0.46,1,0.29,0.99";
      animation_curve_opacity_fade_in = "0.46,1,0.29,0.99";
      animation_curve_opacity_fade_out = "0.5,0.5,0.5,0.5";
      animation_duration_move = 280;
      animation_duration_open = 250;
      animation_duration_tag = 250;
      animation_duration_close = 220;
      animation_duration_focus = 0;

      sloppy_focus = 1;
      warp_cursor = 0;
      cursor_size = 24;

      jump_labels = "HJKLASDFGQWERTYUIOPZXCVBNM";

      bind =
        [
          "SUPER,Return,spawn,ghostty"
          "SUPER,d,spawn,noctalia msg panel-toggle launcher"

          "SUPER,c,killclient,"
          "SUPER,f,togglefullscreen,"
          "SUPER+CTRL,f,togglemaximizescreen,"
          "SUPER,v,togglefloating,"

          "NONE,Print,spawn_shell,grim -g \"$(slurp)\" - | wl-copy --type image/png"

          "SUPER,Left,focusdir,left"
          "SUPER,Right,focusdir,right"
          "SUPER,Up,focusdir,up"
          "SUPER,Down,focusdir,down"

          "SUPER+CTRL,Left,move_client,left"
          "SUPER+CTRL,Right,move_client,right"
          "SUPER+CTRL,Up,move_client,up"
          "SUPER+CTRL,Down,move_client,down"

          "SUPER,j,togglejump,"

          "SUPER+ALT,Left,focusmon,left"
          "SUPER+ALT,Right,focusmon,right"

          "SUPER+ALT+CTRL,Left,tagmon,left"
          "SUPER+ALT+CTRL,Right,tagmon,right"

          "SUPER+SHIFT,r,reload_config"
          "SUPER+SHIFT,Escape,quit"
        ]
        ++ (map (tag: "SUPER,${tag},viewcrossmon,${tag},DP-1") ["1" "2" "3"])
        ++ (map (tag: "SUPER+CTRL,${tag},tagcrossmon,${tag},DP-1") ["1" "2" "3"]);

      bindl = [
        "NONE,XF86AudioPlay,spawn,playerctl play-pause"
        "NONE,XF86AudioPrev,spawn,playerctl previous"
        "NONE,XF86AudioNext,spawn,playerctl next"
      ];

      bindc = [
        "SUPER,Prior,focusdir,left"
        "SUPER,Prior,focusdir,up"

        "SUPER,Next,focusdir,right"
        "SUPER,Next,focusdir,down"
      ];

      mousebind = [
        "SUPER,btn_left,moveresize,curmove"
        "SUPER,btn_right,moveresize,curresize"
      ];

      axisbind = [
        "SUPER,UP,focusdir,left"
        "SUPER,DOWN,focusdir,right"

        "SUPER+CTRL,UP,focusdir,up"
        "SUPER+CTRL,DOWN,focusdir,down"
      ];
    };
  };
}
