{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-server";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Denver";

  nix.settings.experimental-features = ["nix-command" "flakes"];

  virtualisation.docker.enable = true;

  users.users.jacob = {
    isNormalUser = true;
    extraGroups = ["wheel" "docker"];
    packages = with pkgs; [
      tree
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    git
  ];

  fileSystems."/mnt/nas" = {
    device = "192.168.5.162:/volume1/Jacob/AGP-BACKUP";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noatime" ];
  };

  systemd.timers."agp-backup" = {
    wantedBy = ["timers.target"];
    timerConfig = {
      OnBootSec = "5m";
      OnUnitActiveSec = "24h";
      Unit = "agp-backup.service";
    };
  };

  systemd.services."agp-backup" = {
    path = [pkgs.docker];
    script = ''
      BACKUP_DIR=/mnt/nas
      TIMESTAMP=$(date +"%F_%T")
      BACKUP_FILE=$BACKUP_DIR/backup_$TIMESTAMP.sql

      docker compose -p anti-ghost-ping exec -t database pg_dump -U agp agp > $BACKUP_FILE
      find $BACKUP_DIR -type f -name "backup_*.sql" -mtime +7 -exec rm {} \;
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };

  services.openssh.enable = true;

  networking.firewall.allowedTCPPorts = [22];

  system.stateVersion = "24.11"; # Did you read the comment?
}
