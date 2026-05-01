{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./programs/nvim.nix
    ./programs/hyprland.nix
    ./programs/obs.nix
    ./programs/dunst.nix
    ./programs/starship.nix
    ./programs/fish.nix
    ./programs/rofi.nix
    ./programs/waybar.nix
    ./programs/btop.nix
    #./programs/spicetify.nix
    ./programs/hyprpaper.nix
    ./programs/ghostty.nix
  ];
  home = {
    username = "jacob";
    homeDirectory = "/home/jacob";
    sessionVariables = {
      HOME_NIX = "$HOME/.config/nixos/home/home.nix";
      SYS_NIX = "$HOME/.config/nixos/system/configuration.nix";
      BROWSER = "firefox-devedition";
    };
    packages = with pkgs; [
      pcmanfm
      firefox-devedition
      wineWow64Packages.stable
      winetricks
      playerctl
      cliphist
      wl-clipboard
      crosspipe
      obsidian
      insomnia
      hyprpaper
      ripgrep
      inotify-tools
      jetbrains.datagrip
      element-desktop
      gimp
      calibre
      qbittorrent
      mpv
      tailwindcss-language-server
      prismlauncher
      hyprcursor
      ffmpeg-full
      lunar-client
      vinegar
      tagger
      kodi
      nautilus
      blender
      proton-vpn-cli
      inputs.hyprland-contrib.packages.${pkgs.stdenv.hostPlatform.system}.grimblast
      inputs.hytale-launcher.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
    pointerCursor = {
      name = "catppuccin-mocha-light-cursors";
      package = pkgs.catppuccin-cursors.mochaLight;
    };
  };
  gtk = {
    enable = true;
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    gtk4 = {
      extraCss = ''
        tabbar {
          background-color: #1e1e2ed9;
        }
      '';
      theme = null;
    };
  };
  programs.home-manager.enable = true;
  programs.direnv = {
    enable = true;
    config = {
      global = {
        load_dotenv = true;
      };
    };
    nix-direnv = {
      enable = true;
    };
  };
  systemd.user.startServices = "sd-switch";
  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "jacob@leastr.io";
        name = "Leastrio";
      };
      init.defaultBranch = "main";
      credential.helper = "store";
      push.autoSetupRemote = true;
    };
    signing.format = null;
  };
  home.stateVersion = "23.05";
}
