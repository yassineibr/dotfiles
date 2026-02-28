{ config, lib, ... }:
let
  derpPort = 3478;
in
{
  services = {
    headscale = {
      enable = true;
      port = 8085;
      address = "127.0.0.1";
      settings = {
        dns = {
          override_local_dns = true;
          base_domain = "remote.headscale";
          magic_dns = true;
          search_domains = [ "headscale.remote.ibrahimi.xyz" ];
          nameservers.global = [
            "100.64.0.3"
            "100.64.0.5"
          ];
        };
        server_url = "https://headscale.remote.ibrahimi.xyz";
        metrics_listen_addr = "127.0.0.1:8095";
        logtail = {
          enabled = false;
        };
        log = {
          level = "warn";
        };
        ip_prefixes = [ "100.64.0.0/24" ];
        derp.server = {
          enable = true;
          region_id = 999;
          stun_listen_addr = "0.0.0.0:${toString derpPort}";
        };
      };
    };

    nginx.virtualHosts = lib.mkIf config.services.nginx.enable {
      "headscale.remote.ibrahimi.xyz" = {
        forceSSL = true;
        enableACME = true;
        locations = {
          "/" = {
            proxyPass = "http://localhost:${toString config.services.headscale.port}";
            proxyWebsockets = true;
          };
        };
      };
    };
  };

  services.traefik.dynamicConfigOptions = lib.mkIf config.services.traefik.enable {
    http = {
      routers.headscale = {
        rule = "Host(`headscale.remote.ibrahimi.xyz`)";
        service = "headscale";
        tls.certResolver = "letsencrypt";
      };
      services.headscale = {
        loadBalancer.servers = [
          {
            url = "http://localhost:${toString config.services.headscale.port}";
          }
        ];
      };
    };
  };

  # Derp server
  networking.firewall.allowedUDPPorts = [
    derpPort
    3478 # Netbird stun
  ];
  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  environment.systemPackages = [ config.services.headscale.package ];

}
