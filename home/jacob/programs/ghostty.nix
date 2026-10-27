{
  pkgs,
  lib,
  ...
}: {
  programs.ghostty = {
    enable = true;
    package =
      if pkgs.stdenv.isDarwin
      then pkgs.ghostty-bin
      else pkgs.ghostty;
    settings =
      {
        font-family = "JetBrainsMono Nerd Font Mono";
        font-size = "11";
        theme = "Catppuccin Mocha";
        background-opacity = "0.85";
        window-padding-x = "10";
        window-padding-y = "10";
        window-padding-balance = "true";
        window-theme = "ghostty";
      }
      // lib.optionalAttrs pkgs.stdenv.isLinux {
        window-decoration = "false";
      }
      // lib.optionalAttrs pkgs.stdenv.isDarwin {
        font-size = "14";
        macos-titlebar-style = "hidden";
        background-blur = "true";
      };
  };
}
