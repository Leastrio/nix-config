{pkgs, ...}: {
  imports = [./programs];

  home = {
    username = "jacob";
    homeDirectory =
      if pkgs.stdenv.isDarwin
      then "/Users/jacob"
      else "/home/jacob";
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    packages = with pkgs; [
      ripgrep
      obsidian
    ];

    stateVersion = "23.05";
  };

  programs.home-manager.enable = true;

  programs.direnv = {
    enable = true;
    config.global.load_dotenv = true;
    nix-direnv.enable = true;
  };

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
}
