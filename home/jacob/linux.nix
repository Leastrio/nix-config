{
  pkgs,
  inputs,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;
in {
  imports = [
    ./compositors
    ./programs/obs.nix
    ./programs/spicetify.nix
    ./programs/noctalia.nix
  ];

  home = {
    sessionVariables.BROWSER = "firefox-devedition";
    packages = with pkgs; [
      pcmanfm
      firefox-devedition
      wineWow64Packages.stable
      winetricks
      playerctl
      cliphist
      wl-clipboard
      crosspipe
      insomnia
      inotify-tools
      jetbrains.datagrip
      element-desktop
      gimp
      calibre
      qbittorrent
      mpv
      prismlauncher
      hyprcursor
      lunar-client
      vinegar
      tagger
      kodi
      nautilus
      blender
      proton-vpn-cli
      pavucontrol
      vesktop
      protontricks
      mangohud
      r2modman
      inputs.hyprland-contrib.packages.${system}.grimblast
      inputs.hytale-launcher.packages.${system}.default
      inputs.helium.packages.${system}.default
      inputs.jellynav.packages.${system}.default
    ];
    pointerCursor = {
      enable = true;
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

  systemd.user.startServices = "sd-switch";
}
