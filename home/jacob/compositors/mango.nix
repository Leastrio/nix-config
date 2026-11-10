
{
  inputs,
  lib,
  pkgs,
  ...
}: let
  tags = ["1" "2" "3" "4" "5" "6"];

  forTags = f: map f tags;
in {
  imports = [
    inputs.mangowm.hmModules.mango
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
        "tags:1,monitor:HDMI-A-1,app_id:^firefox"
        "tags:2,monitor:DP-1,app_id:^[Ss]potify$"
        "tags:2,monitor:HDMI-A-1,app_id:^vesktop$"
      ];

      window_rule = [
        "is_floating:1,width:1080,height:920,app_id:^dev.noctalia.Noctalia$"
        "is_floating:1,app_id:^Erlang$"
      ];

      tag_rule =
        [
          "id:1,monitor_name:DP-1,layout_name:dwindle"
          "id:1,monitor_name:HDMI-A-1,layout_name:dwindle"
          "id:1,monitor_name:DP-2,layout_name:dwindle"
        ]
        ++ map
          (tag: "id:${tag},monitor_name:DP-1,layout_name:scroller")
          (lib.drop 1 tags)
        ++ map
          (tag: "id:${tag},monitor_name:HDMI-A-1,layout_name:vertical_scroller")
          (lib.drop 1 tags)
        ++ map
          (tag: "id:${tag},monitor_name:DP-2,layout_name:scroller")
          (lib.drop 1 tags);

      scroller_default_proportion = 0.5;
      scroller_proportion_preset = "0.333,0.5,0.667";
      scroller_prefer_center = 1;

      border_px = 2;
      border_radius = 10;

      focus_color = "0xb7bdf8ff";
      border_color = "0x505050ff";

      gap_inner_horizontal = 5;
      gap_inner_vertical = 5;
      gap_outer_horizontal = 10;
      gap_outer_vertical = 10;

      shadows = 1;
      shadows_size = 4;
      shadows_blur = 15;
      shadows_color = "0x1a1a1aee";

      blur = 1;
      blur_layer = 1;

      animations = 1;
      layer_animations = 1;

      animation_type_open = "slide";
      animation_type_close = "slide";

      animation_duration_move = 300;
      animation_duration_open = 300;
      animation_duration_tag = 300;
      animation_duration_close = 300;

      sloppy_focus = 1;
      warp_cursor = 0;
      cursor_size = 24;

      bind =
        [
          "SUPER,Return,spawn,ghostty"
          "SUPER,d,spawn,noctalia msg panel-toggle launcher"

          "SUPER,c,killclient,"
          "SUPER,f,togglefullscreen,"
          "SUPER,v,togglefloating,"

          ''NONE,Print,spawn,grim -g "$(slurp)" - | wl-copy && notify-send "Screenshot copied"''

          "SUPER,Left,focusdir,left"
          "SUPER,Right,focusdir,right"
          "SUPER,Up,focusdir,up"
          "SUPER,Down,focusdir,down"

          "SUPER+CTRL,Left,move_client,left"
          "SUPER+CTRL,Right,move_client,right"
          "SUPER+CTRL,Up,move_client,up"
          "SUPER+CTRL,Down,move_client,down"

          "SUPER,o,toggleoverview,"
          "SUPER+CTRL,f,togglemaximizescreen,"

          "SUPER+ALT,Left,focusmon,left"
          "SUPER+ALT,Right,focusmon,right"

          "SUPER+ALT+CTRL,Left,tagmon,left"
          "SUPER+ALT+CTRL,Right,tagmon,right"

          "SUPER,r,switch_proportion_preset,"
          "SUPER,bracketleft,scroller_stack,left"
          "SUPER,bracketright,scroller_stack,right"

          "SUPER,s,dwindle_toggle_split_direction"
          "SUPER,n,switch_layout"

          "SUPER+SHIFT,r,reload_config"
          "SUPER+SHIFT,Escape,quit"
        ]
        ++ forTags (tag: "SUPER,${tag},view,${tag},0")
        ++ forTags (tag: "SUPER+CTRL,${tag},tag,${tag},0");

      bindl = [
        "NONE,XF86AudioPlay,spawn,playerctl play-pause"
        "NONE,XF86AudioPrev,spawn,playerctl previous"
        "NONE,XF86AudioNext,spawn,playerctl next"
      ];

      mousebind = [
        "SUPER,btn_left,moveresize,curmove"
        "SUPER,btn_right,moveresize,curresize"
      ];

      axisbind = [
        "SUPER,UP,focusdir,left"
        "SUPER,DOWN,focusdir,right"
      ];
    };
  };
}
