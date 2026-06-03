{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    bootspec.enable = true;
    loader.systemd-boot = {
      enable = lib.mkForce false;
      configurationLimit = 5;
    };
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
    initrd.kernelModules = ["amdgpu"];
    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [8080 4000 57621];
    allowedUDPPorts = [51820 5353];
  };

  time.timeZone = "America/Denver";

  nix = {
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  virtualisation.docker.enable = true;

  users.users.jacob = {
    initialPassword = "meow";
    isNormalUser = true;
    home = "/home/jacob";
    extraGroups = ["wheel" "networkmanager" "wireshark" "docker" "dialout"];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  boot.kernelParams = [
    "video=DP-1:2560x1440@170"
    "video=HDMI-A-1:2560x1440@59"
  ];

  zramSwap.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = false;

    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  programs.niri.enable = true;
  programs.wayfire.enable = true;

  security.polkit.enable = true;

  fileSystems."/data" = {
    device = "/dev/disk/by-uuid/8458a125-3b00-4baa-ac24-d45b68644929";
    fsType = "ext4";
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    extraConfig.pipewire."92-low-latency" = {
      context.properties = {
        default.clock.rate = 48000;
        default.clock.quantum = 32;
        default.clock.min-quantum = 32;
        default.clock.max-quantum = 32;
      };
    };
  };

  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "colormix";
      bigclock = "en";
      bigclock_12hr = true;
      brightness_down_key = "null";
      brightness_up_key = "null";
      hide_version_string = true;
      default_input = "password";
      waylandsessions = "${config.services.displayManager.sessionData.desktops}/share/wayland-sessions";
      xsessions = "${config.services.displayManager.sessionData.desktops}/share/xsessions";
      xinitrc = "null";
      restart_cmd = "/run/current-system/sw/bin/systemctl poweroff";
      shutdown_cmd = "/run/current-system/sw/bin/systemctl reboot";
    };
  };

  services.gnome.gnome-keyring.enable = true;
  services.flatpak = {
    enable = true;
    packages = [
      "org.vinegarhq.Sober"
    ];
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  hardware.keyboard.qmk.enable = true;

  systemd.timers."backup-drive" = {
    wantedBy = ["timers.target"];
    timerConfig = {
      OnBootSec = "5m";
      OnUnitActiveSec = "120m";
      Unit = "backup-drive.service";
    };
  };
  systemd.services."backup-drive" = {
    path = [pkgs.rsync];
    script = ''
      nice -n 19 rsync \
        --archive \
        --hard-links \
        --acls \
        --xattrs \
        --sparse \
        --delete-excluded \
        --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found","/var/cache/*","/var/tmp/*"} \
        --exclude '/data' \
        --exclude '/home/*/.cache' \
        --exclude '/home/*/.local/share/Trash' \
        --exclude '/nix' \
        / \
        /data/backup
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };

  documentation.dev.enable = true;

  environment = {
    systemPackages = with pkgs; [
      git
      kdePackages.polkit-kde-agent-1
      man-pages
      man-pages-posix
    ];
    sessionVariables.NIXOS_OZONE_WL = "1";
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];

  system.stateVersion = "23.05"; # Did you read the comment?
}
