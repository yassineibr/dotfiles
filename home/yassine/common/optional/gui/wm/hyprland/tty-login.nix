{ config, pkgs, ... }:
{
  programs.zsh = {
    profileExtra = ''
      if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
          exec ssh-agent Hyprland
        fi
    '';
  };
}
