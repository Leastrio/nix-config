{lib, ...}: let
  tags = ["1" "2" "3" "4" "5" "6"];
  forTags = f: lib.concatMapStringsSep "\n" f tags;
in {
  xdg.configFile."mango/config.conf".text = ''
    monitor_rule=name:^DP-1$,width:2560,height:1440,refresh:170,x:0,y:520,primary:1
    monitor_rule=name:^HDMI-A-1$,width:2560,height:1440,refresh:59,x:2560,y:0,rr:3
    monitor_rule=name:^DP-2$,width:2560,height:1600,refresh:120,x:480,y:1960,scale:1.6

    exec_once=noctalia
    exec_once=wl-paste --type text --watch cliphist store
    exec_once=wl-paste --type image --watch cliphist store
    exec_once=ghostty
    exec_once=firefox-devedition
    exec_once=spotify
    exec_once=vesktop

    window_rule_once=tags:1,monitor:DP-1,app_id:^com.mitchellh.ghostty$
    window_rule_once=tags:1,monitor:HDMI-A-1,app_id:^firefox
    window_rule_once=tags:2,monitor:DP-1,app_id:^[Ss]potify$
    window_rule_once=tags:2,monitor:HDMI-A-1,app_id:^vesktop$

    window_rule=is_floating:1,width:1080,height:920,app_id:^dev.noctalia.Noctalia$
    window_rule=is_floating:1,app_id:^Erlang$

    tag_rule=id:1,monitor_name:DP-1,layout_name:dwindle
    tag_rule=id:1,monitor_name:HDMI-A-1,layout_name:dwindle
    tag_rule=id:1,monitor_name:DP-2,layout_name:dwindle
    ${lib.concatMapStringsSep "\n" (t: "tag_rule=id:${t},monitor_name:DP-1,layout_name:scroller") (lib.drop 1 tags)}
    ${lib.concatMapStringsSep "\n" (t: "tag_rule=id:${t},monitor_name:HDMI-A-1,layout_name:vertical_scroller") (lib.drop 1 tags)}
    ${lib.concatMapStringsSep "\n" (t: "tag_rule=id:${t},monitor_name:DP-2,layout_name:scroller") (lib.drop 1 tags)}

    scroller_default_proportion=0.5
    scroller_proportion_preset=0.333,0.5,0.667
    scroller_prefer_center=1

    border_px=2
    border_radius=10
    focus_color=0xb7bdf8ff
    border_color=0x505050ff
    gap_inner_horizontal=5
    gap_inner_vertical=5
    gap_outer_horizontal=10
    gap_outer_vertical=10
    shadows=1
    shadows_size=4
    shadows_blur=15
    shadows_color=0x1a1a1aee
    blur=1
    blur_layer=1

    animations=1
    layer_animations=1
    animation_type_open=slide
    animation_type_close=slide
    animation_duration_move=300
    animation_duration_open=300
    animation_duration_tag=300
    animation_duration_close=300

    sloppy_focus=1
    warp_cursor=0
    cursor_size=24

    bind=SUPER,Return,spawn,ghostty
    bind=SUPER,d,spawn,noctalia msg panel-toggle launcher
    bind=SUPER,c,killclient,
    bind=SUPER,f,togglefullscreen,
    bind=SUPER,v,togglefloating,
    bind=NONE,Print,spawn,grimblast --notify copy area
    bindl=NONE,XF86AudioPlay,spawn,playerctl play-pause
    bindl=NONE,XF86AudioPrev,spawn,playerctl previous
    bindl=NONE,XF86AudioNext,spawn,playerctl next
    mousebind=SUPER,btn_left,moveresize,curmove
    mousebind=SUPER,btn_right,moveresize,curresize

    bind=SUPER,Left,focusdir,left
    bind=SUPER,Right,focusdir,right
    bind=SUPER,Up,focusdir,up
    bind=SUPER,Down,focusdir,down
    bind=SUPER+CTRL,Left,move_client,left
    bind=SUPER+CTRL,Right,move_client,right
    bind=SUPER+CTRL,Up,move_client,up
    bind=SUPER+CTRL,Down,move_client,down
    axisbind=SUPER,UP,focusdir,left
    axisbind=SUPER,DOWN,focusdir,right
    bind=SUPER,o,toggleoverview,
    bind=SUPER+CTRL,f,togglemaximizescreen,

    ${forTags (t: "bind=SUPER,${t},view,${t},0")}
    ${forTags (t: "bind=SUPER+CTRL,${t},tag,${t},0")}

    bind=SUPER+ALT,Left,focusmon,left
    bind=SUPER+ALT,Right,focusmon,right
    bind=SUPER+ALT+CTRL,Left,tagmon,left
    bind=SUPER+ALT+CTRL,Right,tagmon,right

    bind=SUPER,r,switch_proportion_preset,
    bind=SUPER,bracketleft,scroller_stack,left
    bind=SUPER,bracketright,scroller_stack,right

    bind=SUPER,s,dwindle_toggle_split_direction

    bind=SUPER,n,switch_layout
    bind=SUPER+SHIFT,r,reload_config
    bind=SUPER+SHIFT,Escape,quit
  '';
}