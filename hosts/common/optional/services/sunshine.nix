{ pkgs, config, ... }:
let
  configFile = pkgs.writeTextDir "config/sunshine.conf" ''
    # origin_web_ui_allowed=pc
  '';

  sunshinePort = 47989;

  # Fix for NixOS 23.11 removing a dependency
  # See https://github.com/NixOS/nixpkgs/issues/271333
  # Solved by https://github.com/NixOS/nixpkgs/pull/271352 but nit yet ported to unstable or later release
  # Should not impact previous release (<23.11)
  sunshineOverride = pkgs.sunshine.overrideAttrs (prev: {
    runtimeDependencies = prev.runtimeDependencies ++ [ pkgs.libglvnd ];
  });
in
{
  networking.firewall = {
    # SSH and Sunshine ports based on offset of 47989 by default
    # See https://docs.lizardbyte.dev/projects/sunshine/en/latest/about/advanced_usage.html#port
    allowedTCPPorts = [
      (sunshinePort - 5)
      sunshinePort
      (sunshinePort + 1) # Web UI
      (sunshinePort + 21)
    ];
    allowedUDPPorts = [
      (sunshinePort + 9)
      (sunshinePort + 10)
      (sunshinePort + 11)
      (sunshinePort + 13)
    ];
  };

  environment.systemPackages = [ sunshineOverride ];

  security.wrappers.sunshine = {
    owner = "root";
    group = "root";
    capabilities = "cap_sys_admin+p";
    source = "${sunshineOverride}/bin/sunshine";
  };

  # Inspired from https://github.com/LizardByte/Sunshine/blob/5bca024899eff8f50e04c1723aeca25fc5e542ca/packaging/linux/sunshine.service.in
  systemd.user.services.sunshine = {
    description = "Sunshine server";
    wantedBy = [ "graphical-session.target" ];
    startLimitIntervalSec = 500;
    startLimitBurst = 5;
    partOf = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];

    serviceConfig = {
      ExecStart = "${config.security.wrapperDir}/sunshine ${configFile}/config/sunshine.conf";
      Restart = "on-failure";
      RestartSec = "5s";
    };
  };

  # Avahi is used by Sunshine
  services.avahi.publish.userServices = true;

  # Required to simulate input
  boot.kernelModules = [ "uinput" ];

  services.udev.extraRules = ''
    KERNEL=="uinput", SUBSYSTEM=="misc", OPTIONS+="static_node=uinput", TAG+="uaccess"
  '';
}
