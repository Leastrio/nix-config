{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia = {
    enable = true;
    settings = ''
    [appLauncher]
enableClipboardHistory = false
enableSessionSearch = false
enableSettingsSearch = false
enableWindowsSearch = false
overviewLayer = true
terminalCommand = "ghostty -e"

[audio]
enable_overdrive = true
preferredPlayer = "spotify"

[bar]
barType = "simple"
density = "comfortable"
monitors = [ "DP-1", "HDMI-A-1" ]
outerCorners = false
position = "top"

    [bar.widgets]
    capsule = true
    center = [ "workspaces" ]
    end = [ "tray", "volume", "battery", "date", "control-center" ]
    margin_ends = 0
    padding = 6
    radius = 0
    start = [ "launcher", "group:g1", "media" ]

        [[bar.widgets.capsule_group]]
        enabled = true
        fill = "surface_variant"
        id = "g1"
        members = [ "cpu", "temp", "ram", "sysmon" ]
        opacity = 1.0
        padding = 6.0

        [[bar.widgets.left]]
        id = "Launcher"

        [[bar.widgets.left]]
        compactMode = false
        id = "SystemMonitor"
        showCpuFreq = false
        showCpuTemp = false
        showCpuUsage = true
        showDiskUsage = true
        showDiskUsageAsPercent = true
        showMemoryUsage = true
        showNetworkStats = true

        [[bar.widgets.left]]
        id = "MediaMini"
        maxWidth = 500

        [[bar.widgets.right]]
        id = "Tray"

        [[bar.widgets.right]]
        id = "NotificationHistory"

        [[bar.widgets.right]]
        displayMode = "alwaysShow"
        id = "Volume"

        [[bar.widgets.right]]
        formatHorizontal = "h:mm AP ddd, MMM dd"
        formatVertical = "h:mm AP ddd, MMM dd"
        id = "Clock"
        tooltipFormat = "h:mm AP ddd, MMM dd"

        [[bar.widgets.right]]
        colorizeDistroLogo = true
        enableColorization = true
        id = "ControlCenter"
        useDistroLogo = true

[battery.device."/org/freedesktop/UPower/devices/battery_hidpp_battery_0"]
warning_threshold = 10

[colorSchemes]
predefinedScheme = "Catppuccin"

[config]

[[controlCenter.shortcuts.left]]
id = "Network"

[[controlCenter.shortcuts.left]]
id = "WallpaperSelector"

[[controlCenter.shortcuts.left]]
id = "NoctaliaPerformance"

[[controlCenter.shortcuts.right]]
id = "Notifications"

[[controlCenter.shortcuts.right]]
id = "NightLight"

[[controlCenter.cards]]
enabled = true
id = "profile-card"

[[controlCenter.cards]]
enabled = true
id = "shortcuts-card"

[[controlCenter.cards]]
enabled = true
id = "audio-card"

[[controlCenter.cards]]
enabled = false
id = "brightness-card"

[[controlCenter.cards]]
enabled = false
id = "weather-card"

[[controlCenter.cards]]
enabled = true
id = "media-sysmon-card"

[control_center]
hidden_tabs = [ "monitor", "bluetooth", "screen-time" ]

    [[control_center.shortcuts]]
    type = "caffeine"

    [[control_center.shortcuts]]
    type = "nightlight"

    [[control_center.shortcuts]]
    type = "power_profile"

[desktopWidgets]
enabled = true
gridSnap = true
gridSnapScale = true
overviewEnabled = true

    [[desktopWidgets.monitorWidgets]]
    name = "DP-2"

        [[desktopWidgets.monitorWidgets.widgets]]
        hideMode = "visible"
        id = "MediaPlayer"
        roundedCorners = true
        scale = 1.25
        showAlbumArt = true
        showBackground = true
        showButtons = true
        showVisualizer = false
        x = 20
        y = 20

        [[desktopWidgets.monitorWidgets.widgets]]
        diskPath = "/"
        id = "SystemStat"
        layout = "bottom"
        roundedCorners = true
        scale = 1.5
        showBackground = true
        statType = "CPU"
        x = 20
        y = 800

        [[desktopWidgets.monitorWidgets.widgets]]
        diskPath = "/"
        id = "SystemStat"
        layout = "bottom"
        roundedCorners = true
        scale = 1.5
        showBackground = true
        statType = "Memory"
        x = 1220
        y = 800

        [[desktopWidgets.monitorWidgets.widgets]]
        diskPath = "/"
        id = "SystemStat"
        layout = "bottom"
        roundedCorners = true
        scale = 1.5
        showBackground = true
        statType = "Network"
        x = 420
        y = 800

        [[desktopWidgets.monitorWidgets.widgets]]
        diskPath = "/"
        id = "SystemStat"
        layout = "bottom"
        roundedCorners = true
        scale = 1.5
        showBackground = true
        statType = "Disk"
        x = 820
        y = 800

        [[desktopWidgets.monitorWidgets.widgets]]
        diskPath = "/"
        id = "SystemStat"
        layout = "bottom"
        roundedCorners = true
        scale = 1.5
        showBackground = true
        statType = "CPU"
        x = 20
        y = 800

        [[desktopWidgets.monitorWidgets.widgets]]
        id = "Weather"
        roundedCorners = true
        scale = 1.4812729428898961
        showBackground = true
        x = 1120
        y = 320

        [[desktopWidgets.monitorWidgets.widgets]]
        clockColor = "none"
        clockStyle = "digital"
        customFont = ""
        format = "HH:mm\\nd MMMM yyyy"
        id = "Clock"
        roundedCorners = true
        scale = 1.3333333333333333
        showBackground = true
        useCustomFont = false
        x = 1380
        y = 20

[desktop_widgets]
schema_version = 2
widget_order = [
    "desktop-widget-0000000000000001",
    "desktop-widget-0000000000000002",
    "desktop-widget-0000000000000003",
    "desktop-widget-0000000000000004",
    "desktop-widget-0000000000000005",
    "desktop-widget-0000000000000006",
    "desktop-widget-0000000000000008"
]

    [desktop_widgets.grid]
    cell_size = 16
    major_interval = 4
    visible = true

    [desktop_widgets.widget.desktop-widget-0000000000000001]
    box_height = 0.0
    box_width = 0.0
    cx = 189.0
    cy = 132.0
    output = "DP-2"
    rotation = 0.0
    type = "media_player"

        [desktop_widgets.widget.desktop-widget-0000000000000001.settings]
        layout = "horizontal"

    [desktop_widgets.widget.desktop-widget-0000000000000002]
    box_height = 192.0
    box_width = 368.0
    cx = 200.0
    cy = 884.0
    output = "DP-2"
    rotation = 0.0
    type = "sysmon"

        [desktop_widgets.widget.desktop-widget-0000000000000002.settings]
        display = "graph"
        stat = "cpu_usage"
        stat2 = "cpu_temp"

    [desktop_widgets.widget.desktop-widget-0000000000000003]
    box_height = 192.0
    box_width = 384.0
    cx = 592.0
    cy = 884.0
    output = "DP-2"
    rotation = 0.0
    type = "sysmon"

        [desktop_widgets.widget.desktop-widget-0000000000000003.settings]
        display = "graph"
        network_speed_compact = false
        network_speed_unit = "auto"
        stat = "net_rx"
        stat2 = ""

    [desktop_widgets.widget.desktop-widget-0000000000000004]
    box_height = 192.0
    box_width = 384.0
    cx = 992.0
    cy = 884.0
    output = "DP-2"
    rotation = 0.0
    type = "sysmon"

        [desktop_widgets.widget.desktop-widget-0000000000000004.settings]
        display = "graph"
        stat = "net_tx"
        stat2 = ""

    [desktop_widgets.widget.desktop-widget-0000000000000005]
    box_height = 192.0
    box_width = 384.0
    cx = 1392.0
    cy = 884.0
    output = "DP-2"
    rotation = 0.0
    type = "sysmon"

        [desktop_widgets.widget.desktop-widget-0000000000000005.settings]
        display = "graph"
        stat = "ram_pct"
        stat2 = ""

    [desktop_widgets.widget.desktop-widget-0000000000000006]
    box_height = 0.0
    box_width = 0.0
    cx = 1484.0
    cy = 389.0
    output = "DP-2"
    rotation = 0.0
    type = "weather"

        [desktop_widgets.widget.desktop-widget-0000000000000006.settings]
        forecast_days = 3
        show_forecast = true

    [desktop_widgets.widget.desktop-widget-0000000000000008]
    box_height = 0.0
    box_width = 0.0
    cx = 1441.0
    cy = 109.0
    output = "DP-2"
    rotation = 0.0
    type = "clock"

        [desktop_widgets.widget.desktop-widget-0000000000000008.settings]
        clock_style = "digital"
        format = "%I:%M %p"

[dock]
enabled = false

[general]
lockOnSuspend = false

[idle]
pre_action_fade_seconds = 0

[location]
address = "Colorado Springs, Colorado"
autoLocate = false
name = "Colorado Springs"
use12hourFormat = true
useFahrenheit = true

[lockscreen]
enabled = false

[lockscreen_widgets]
enabled = false
schema_version = 2
widget_order = [ "lockscreen-login-box@HDMI-A-1", "lockscreen-login-box@DP-2", "lockscreen-login-box@DP-1" ]

    [lockscreen_widgets.grid]
    cell_size = 16
    major_interval = 4
    visible = true

    [lockscreen_widgets.widget."lockscreen-login-box@DP-1"]
    box_height = 70.0
    box_width = 400.0
    cx = 1280.0
    cy = 1321.0
    output = "DP-1"
    rotation = 0.0
    type = "login_box"

        [lockscreen_widgets.widget."lockscreen-login-box@DP-1".settings]
        background_color = "surface_variant"
        background_opacity = 0.88
        background_radius = 12.0
        center_password_text = false
        input_opacity = 1.0
        input_radius = 6.0
        show_caps_lock = true
        show_keyboard_layout = true
        show_login_button = true
        show_password_hint = true

    [lockscreen_widgets.widget."lockscreen-login-box@DP-2"]
    box_height = 70.0
    box_width = 400.0
    cx = 800.0
    cy = 881.0
    output = "DP-2"
    rotation = 0.0
    type = "login_box"

        [lockscreen_widgets.widget."lockscreen-login-box@DP-2".settings]
        background_color = "surface_variant"
        background_opacity = 0.88
        background_radius = 12.0
        center_password_text = false
        input_opacity = 1.0
        input_radius = 6.0
        show_caps_lock = true
        show_keyboard_layout = true
        show_login_button = true
        show_password_hint = true

    [lockscreen_widgets.widget."lockscreen-login-box@HDMI-A-1"]
    box_height = 70.0
    box_width = 400.0
    cx = 720.0
    cy = 2441.0
    output = "HDMI-A-1"
    rotation = 0.0
    type = "login_box"

        [lockscreen_widgets.widget."lockscreen-login-box@HDMI-A-1".settings]
        background_color = "surface_variant"
        background_opacity = 0.88
        background_radius = 12.0
        center_password_text = false
        input_opacity = 1.0
        input_radius = 6.0
        show_caps_lock = true
        show_keyboard_layout = true
        show_login_button = true
        show_password_hint = true

[notification]
layer = "overlay"

[notifications]
density = "compact"
enableMediaToast = false

    [notifications.saveToHistory]
    critical = true
    low = false
    normal = false

[osd.kinds]
media = false

[sessionMenu]
enableCountdown = false

    [[sessionMenu.powerOptions]]
    action = "reboot"
    command = ""
    countdownEnabled = false
    enabled = true
    keybind = "1"

    [[sessionMenu.powerOptions]]
    action = "shutdown"
    command = ""
    countdownEnabled = false
    enabled = true
    keybind = "2"

    [[sessionMenu.powerOptions]]
    action = "rebootToUefi"
    command = ""
    countdownEnabled = false
    enabled = true
    keybind = "3"

    [[sessionMenu.powerOptions]]
    action = "userspaceReboot"
    command = ""
    countdownEnabled = false
    enabled = true
    keybind = "4"

    [[sessionMenu.powerOptions]]
    action = "lock"
    enabled = false

    [[sessionMenu.powerOptions]]
    action = "suspend"
    enabled = false

    [[sessionMenu.powerOptions]]
    action = "hibernate"
    enabled = false

    [[sessionMenu.powerOptions]]
    action = "logout"
    enabled = false

[shell]
font_family = "JetBrainsMono NF"

    [shell.launcher]
    compact = true

    [[shell.session.actions]]
    action = "logout"
    countdown_seconds = 0.0
    enabled = true
    shortcut = "2"
    variant = "default"

    [[shell.session.actions]]
    action = "reboot"
    countdown_seconds = 0.0
    enabled = true
    shortcut = "4"
    variant = "default"

    [[shell.session.actions]]
    action = "shutdown"
    countdown_seconds = 0.0
    enabled = true
    shortcut = "5"
    variant = "destructive"

[templates]

[theme]
builtin = "Catppuccin"

    [theme.templates]
    enable_builtin_templates = false
    enable_community_templates = false

[ui]
fontDefault = "JetBrainsMono Nerd Font"

[wallpaper]
directory = "/home/jacob/Wallpapers"
skipStartupTransition = true

    [wallpaper.default]
    path = "/home/jacob/Wallpapers/tropic_island_night.jpg"

    [wallpaper.last]
    path = "/home/jacob/Wallpapers/tropic_island_night.jpg"

[widget.battery]
device = "/org/freedesktop/UPower/devices/battery_hidpp_battery_0"

[widget.control-center]
glyph = "adjustments"

[widget.cpu]
display = "text"

[widget.date]
format = "%-l:%M %p %a, %b %d"

[widget.media]
max_length = 345

[widget.ram]
display = "text"

[widget.sysmon]
display = "text"
stat = "disk_pct"

[widget.temp]
display = "text"

[widget.workspaces]
display = "name"
    '';
  };
}
