{lib, ...}: {
  # systemd.services.docker.wantedBy = lib.mkForce [];

  virtualisation.docker = {
    enable = true;
    enableOnBoot = lib.mkDefault false;
  };
}
