{pkgs, ...}: {
  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "JetBrainsMono Nerd Font Mono";
      font-size = "11";
      theme = "Catppuccin Mocha";
      background-opacity = "0.85";
      window-padding-x = "10";
      window-padding-y = "10";
      window-padding-balance = "true";
      window-decoration = "false";
      window-theme = "ghostty";
    };
  };
}
