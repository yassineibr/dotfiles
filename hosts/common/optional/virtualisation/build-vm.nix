{
  lib,
  pkgs,
  inputs,
  config,
  ...
}:
{
  virtualisation.vmVariant = {
    users.users.yassine = {
      initialPassword = "test";
    };
    users.groups.test = { };

    virtualisation = {
      memorySize = 8192;
      cores = 2;

      qemu.options = [
        "-device virtio-vga-gl"
        "-display sdl,gl=on,show-cursor=off"
        "-audio pa,model=hda"
      ];
    };

    environment.sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
    };

    services.interception-tools.enable = lib.mkForce false;
  };
}
