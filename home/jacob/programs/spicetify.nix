{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.spicetify-nix.homeManagerModules.default];

  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  in {
    enable = true;
    experimentalFeatures = true;
    alwaysEnableDevTools = true;
    enabledExtensions = with spicePkgs.extensions; [
      betterGenres
      lastfm
      songStats
      fullAlbumDate
    ];
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
  };
}
