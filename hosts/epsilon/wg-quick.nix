{
  config,
  pkgs,
  lib,
  ...
}:
let
  wireguard-conf-path = config.sops.secrets."wireguard-conf/${config.networking.hostName}".path;
in
{
  sops.secrets."wireguard-conf/${config.networking.hostName}" = { };

  networking.nat.enable = true;
  networking.nat.externalInterface = "end0";
  networking.nat.internalInterfaces = [ "wg0" ];

  networking.firewall = {
    allowedUDPPorts = [ 51820 ];
  };

  networking.wg-quick.interfaces = {
    wg0 = {
      configFile = wireguard-conf-path;
    };
  };

  systemd.timers."wireguard_reresolve-dns" = {
    description = "Periodically reresolve DNS of all WireGuard endpoints";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*:*:0/30";
    };
  };

  systemd.services."wireguard_reresolve-dns" = {
    description = "Periodically reresolve DNS of all WireGuard endpoints";
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
    script = ''
      /var/lib/wireguard/bin/reresolve-dns.sh ${wireguard-conf-path} wg0
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
    path = with pkgs; [
      wireguard-tools
      bash
    ];
  };

  systemd.timers."wg0-check" = {
    description = "Runs wg0 check every 1 minutes";
    wantedBy = [ "multi-user.target" ];
    timerConfig = {
      OnBootSec = "1min";
      OnUnitActiveSec = "1min";
      Unit = "wg0-check.service";
    };
  };

  systemd.services."wg0-check" = {
    description = "check if wg0 is up";
    script = ''
      ${pkgs.bash}/bin/bash -c 'wg show wg0 &> /dev/null; if [ $? == 1 ]; then systemctl restart wg-quick-wg0; fi'
    '';
    serviceConfig = {
      Type = "simple";
      User = "root";
    };
    path = with pkgs; [
      wireguard-tools
      bash
    ];
  };
  systemd.services.wg-quick-wg0.serviceConfig.Restart = lib.mkForce "on-failure";
}
