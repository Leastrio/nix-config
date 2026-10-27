{
  self,
  pkgs,
  ...
}: {
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  system.primaryUser = "jacob";
  user.users.jacob = {
    name = "jacob";
    home = "/Users/jacob";
  };

  environment.systemPackages = with pkgs; [
    nixd
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  programs.fish.enable = true;

  nix = {
    settings.experimental-features = ["nix-command" "flakes"];
    optimise.automatic = true;
    gc = {
      automatic = true;
      interval = {
        Weekday = 0;
        Hour = 3;
        Minute = 0;
      };
      options = "--delete-older-than 30d";
    };
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  system.configurationRevision = self.rev or self.dirtyRev or null;
  system.stateVersion = 6;
}
