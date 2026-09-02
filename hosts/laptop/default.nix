{ self, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    nixd
    sbcl
  ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  security.pam.services.sudo_local.touchIdAuth = true;
  system.configurationRevision = self.rev or self.dirtyRev or null;
  nixpkgs.hostPlatform = "aarch64-darwin";
  system.stateVersion = 6;
}
