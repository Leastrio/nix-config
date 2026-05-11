{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  users.users.jacob = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };

  services.radarr = {
    enable = true;
    openFirewall = true;
  };

  services.sonarr = {
    enable = true;
    openFirewall = true;
  };

  services.sabnzbd = {
    enable = true;
    openFirewall = true;
    settings = {
      misc = {
        bandwidth_max = "100MB/s";
        cache_limit = "1GB";
      };
      servers."newshosting" = {
        required = true;
        displayname = "Newshosting";
        name = "Newshosting";
        host = "news.newshosting.com";
      };
    };
  };

  services.seerr = {
    enable = true;
    openFirewall = true;
  };
}
