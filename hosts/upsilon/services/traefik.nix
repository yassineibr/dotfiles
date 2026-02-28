{ pkgs, config, ... }:
{
  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  services.traefik = {
    enable = true;
    group = "docker";

    # supplementaryGroups = [
    #   "docker"
    # ];

    # dynamic.dir = "/etc/traefik/dynamic";

    # dynamic.files = {
    #   internal-only.settings = {
    dynamicConfigOptions = {
      http.middlewares.internal-ip-allowlist.ipAllowList.sourceRange = [
        "127.0.0.1/32"
        "192.168.0.0/16"
        "10.0.0.0/8"
        "172.16.0.0/12"
        "100.64.0.0/10" # Tailscale/CGNAT
      ];
      # };
    };

    staticConfigOptions = {
      accessLog = {
        # Optional: File path for logs, otherwise sent to stdout
        filePath = "${config.services.traefik.dataDir}/access.log";
        # format = "json"; # Options: "json" or "common"
        format = "common"; # Options: "json" or "common"
      };

      entryPoints = {
        web = {
          address = ":80";
          asDefault = true;
          http.redirections.entrypoint = {
            to = "websecure";
            scheme = "https";
          };
        };

        websecure = {
          address = ":443";
          asDefault = true;
          http.tls.certResolver = "letsencrypt";
        };
      };

      certificatesResolvers.letsencrypt.acme = {
        email = "postmaster@ibrahimi.xyz";
        storage = "${config.services.traefik.dataDir}/acme.json";
        httpChallenge.entryPoint = "web";
      };

      providers.docker = {
        # enable = true;
        exposedByDefault = false; # Only expose containers with specific labels
      };

      log = {
        level = "INFO";
        filePath = "${config.services.traefik.dataDir}/traefik.log";
        format = "json";
      };
    };
  };

}
