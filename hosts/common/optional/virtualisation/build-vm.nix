{
  lib,
  pkgs,
  inputs,
  config,
  ...
}:
{
  virtualisation.vmVariant = {
    services.greetd = {
      settings = {
        initial_session = {
          command = "ssh-agent Hyprland";
          user = "yassine";
        };
      };
    };

    virtualisation.sharedDirectories = {
      ssh-keys = {
        source = "/etc/ssh";
        target = "/etc/ssh";
        securityModel = "none";
      };
    };

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
