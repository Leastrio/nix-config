{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./programs
    inputs.nix-index-database.homeModules.nix-index
  ];

  home = {
    username = "jacob";
    homeDirectory =
      if pkgs.stdenv.hostPlatform.isDarwin
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
      credential.helper =
        if pkgs.stdenv.hostPlatform.isDarwin
        then "osxkeychain"
        else "${pkgs.gitFull}/bin/git-credential-libsecret";
      push.autoSetupRemote = true;
    };
    signing.format = null;
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      server = {
        HostName = "192.168.5.195";
        User = "jacob";
      };
      media = {
        HostName = "192.168.5.239";
        User = "jacob";
      };
    };
  };

  programs.nix-index.enable = true;
  programs.nix-index-database.comma.enable = true;

  programs.eza = {
    enable = true;
    icons = "auto";
    git = true;
  };
}
