{
  inputs,
  pkgs,
  config,
  ...
}:
{
  wayland.windowManager.hyprland = {
    settings = {
      bind = [
        "$mainMod, F3, togglespecialworkspace, kali"
        "$mainMod SHIFT, F3, movetoworkspace, special:kali"
      ];
      workspace = [
        "special:kali, on-created-empty:[fakefullscreen] virt-manager --connect qemu:///system --show-domain-console kali, gapsout:10"
      ];
    };
  };
}
