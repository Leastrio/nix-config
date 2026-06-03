{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
    settings = {
      appLauncher = {
        enableClipboardHistory = false;
        enableSettingsSearch = false;
        enableWindowsSearch = false;
        enableSessionSearch = false;
        overviewLayer = true;
        terminalCommand = "ghostty -e";
      };
      audio.preferredPlayer = "spotify";
      bar = {
        position = "top";
        barType = "simple";
        density = "comfortable";
        outerCorners = false;
        widgets = {
          left = [
            {
              id = "Launcher";
            }
            {
              id = "SystemMonitor";
              compactMode = false;
              showCpuUsage = true;
              showCpuFreq = false;
              showCpuTemp = false;
              showDiskUsage = true;
              showDiskUsageAsPercent = true;
              showMemoryUsage = true;
              showNetworkStats = true;
            }
            {
              id = "MediaMini";
              maxWidth = 500;
            }
          ];
          center = [
            {
              id = "Workspace";
              labelMode = "index";
            }
          ];
          right = [
            {
              id = "Tray";
            }
            {
              id = "NotificationHistory";
            }
            {
              id = "Volume";
              displayMode = "alwaysShow";
            }
            {
              id = "Clock";
              formatHorizontal = "h:mm AP ddd, MMM dd";
              formatVertical = "h:mm AP ddd, MMM dd";
              tooltipFormat = "h:mm AP ddd, MMM dd";
            }
            {
              id = "ControlCenter";
              useDistroLogo = true;
              enableColorization = true;
              colorizeDistroLogo = true;
            }
          ];
        };
      };
      colorSchemes.predefinedScheme = "Catppuccin";
      controlCenter = {
        cards = [
          {
            enabled = true;
            id = "profile-card";
          }
          {
            enabled = true;
            id = "shortcuts-card";
          }
          {
            enabled = true;
            id = "audio-card";
          }
          {
            enabled = false;
            id = "brightness-card";
          }
          {
            enabled = false;
            id = "weather-card";
          }
          {
            enabled = true;
            id = "media-sysmon-card";
          }
        ];
        shortcuts = {
          left = [
            { id = "Network"; } { id = "WallpaperSelector"; } { id = "NoctaliaPerformance"; }
          ];
          right = [
            { id = "Notifications"; } { id = "NightLight"; }
          ];
        };
      };
      dock.enabled = false;
      general = {
        lockOnSuspend = false;
      };
      location = {
        autoLocate = false;
        name = "Colorado Springs";
        use12hourFormat = true;
        useFahrenheit = true;
      };
      notifications = {
        density = "compact";
        enableMediaToast = false;
        saveToHistory = {
          low = false;
          normal = false;
          critical = true;
        };
      };
      ui.fontDefault = "JetBrainsMono Nerd Font";
      wallpaper = {
        directory = "/home/jacob/Wallpapers";
        skipStartupTransition = true;
      };
      sessionMenu = {
        enableCountdown = false;
        powerOptions = [
          {
            action = "reboot";
            enabled = true;
            command = "";
            countdownEnabled = false;
            keybind = "1";
          }
          {
            action = "shutdown";
            enabled = true;
            command = "";
            countdownEnabled = false;
            keybind = "2";
          }
          {
            action = "rebootToUefi";
            enabled = true;
            command = "";
            countdownEnabled = false;
            keybind = "3";
          }
          {
            action = "userspaceReboot";
            enabled = true;
            command = "";
            countdownEnabled = false;
            keybind = "4";
          }
          {
            action = "lock";
            enabled = false;
          }
          {
            action = "suspend";
            enabled = false;
          }
          {
            action = "hibernate";
            enabled = false;
          }
          {
            action = "logout";
            enabled = false;
          }
        ];
      };
    };
  };
}
