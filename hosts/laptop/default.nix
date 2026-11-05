{
  self,
  pkgs,
  ...
}: {
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  system.primaryUser = "jacob";
  users.users.jacob = {
    name = "jacob";
    home = "/Users/jacob";
    shell = pkgs.fish;
  };

  environment.shells = [ pkgs.fish ];
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    nixd
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  homebrew = {
    enable = true;
    enableFishIntegration = true;
  };

  services.jankyborders = {
    enable = true;
    width = 4.0;
    hidpi = true;
    active_color = "0xffcba6f7"; # Catppuccin Mocha blue
    inactive_color = "0xff45475a"; # no border on unfocused windows
  };

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
