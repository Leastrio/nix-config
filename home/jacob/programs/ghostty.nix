{
  pkgs,
  lib,
  ...
}: {
  programs.ghostty = {
    enable = true;
    package =
      if pkgs.stdenv.hostPlatform.isDarwin
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
      // lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux {
        window-decoration = "false";
      }
      // lib.optionalAttrs pkgs.stdenv.hostPlatform.isDarwin {
        font-size = "13";
        background-blur = "true";
      };
  };
}
