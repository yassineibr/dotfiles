{
  config,
  pkgs,
  lib,
  ...
}:

{
  services.uptime-kuma = {
    enable = true;
    settings = {
      HOST = "0.0.0.0";
      PORT = "4001";
    };
  };

  networking.firewall.interfaces."tailscale0".allowedTCPPorts = [
    (lib.toInt config.services.uptime-kuma.settings.PORT)
  ];

  networking.firewall.allowedTCPPorts = lib.mkIf (!config.services.traefik.enable) [ 48080 ];

  services.traefik.dynamicConfigOptions = lib.mkIf config.services.traefik.enable {
    # services.traefik.dynamic.files.uptime-kuma.settings = lib.mkIf config.services.traefik.enable {
    http = {
      routers.uptime-kuma = {
        rule = "Host(`status.remote.ibrahimi.xyz`)";
        service = "uptime-kuma";
        tls.certResolver = "letsencrypt";
        middlewares = [ "internal-ip-allowlist" ];
      };
      services.uptime-kuma = {
        loadBalancer.servers = [
          {
            url = "http://localhost:${config.services.uptime-kuma.settings.PORT}";
          }
        ];
      };
    };
  };

  services.nginx.virtualHosts = lib.mkIf config.services.nginx.enable {
    "status.remote.ibrahimi.xyz" = {
      forceSSL = true;
      enableACME = true;
      locations = {
        "/" = {
          proxyPass = "http://localhost:${config.services.uptime-kuma.settings.PORT}";
          proxyWebsockets = true;
          extraConfig = ''
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header Host $host;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection $connection_upgrade;
            # stub_status on;
            # access_log off;
            allow 192.168.1.0/24;
            allow 172.24.0.2;
            allow 10.13.13.0/24;
            allow 10.88.0.0/16;
            allow 100.64.0.0/10;
            deny all;
          '';
        };
      };
    };
  };

}
