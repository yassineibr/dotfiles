{ pkgs, lib, ... }:
let
  hypr_sock = "$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock";
in
{
  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
    configDir = ./bar;
  };
  home.packages = [
    pkgs.jq

    (pkgs.writeShellScriptBin "eww-get-volume" ''
      volume=$(wpctl get-volume @DEFAULT_SINK@)
      if echo $volume | grep 'MUTED'; then
        echo 0
      else
        echo $volume | awk '{ print $2 }'
      fi
    '')

    (pkgs.writeShellScriptBin "eww-change-active-workspace" ''
      direction=$1
      current=$2
      if test "$direction" = "down"
      then
        hyprctl dispatch workspace e-1
      elif test "$direction" = "up"
      then
        hyprctl dispatch workspace e+1
      fi
    '')

    (pkgs.writeShellScriptBin "eww-get-active-workspace" ''
      hyprctl monitors -j | jq '.[] | select(.focused) | .activeWorkspace.id'

      ${lib.getExe pkgs.socat} -u UNIX-CONNECT:${hypr_sock} - |
        stdbuf -o0 awk -F '>>|,' -e '/^workspace>>/ {print $2}' -e '/^focusedmon>>/ {print $3}'
    '')

    (pkgs.writeShellScriptBin "eww-get-workspaces" ''
      spaces (){
      	WORKSPACE_WINDOWS=$(hyprctl workspaces -j | jq 'map({key: .id | tostring, value: .windows}) | from_entries')
      	seq 1 10 | jq --argjson windows "$WORKSPACE_WINDOWS" --slurp -Mc 'map(tostring) | map({id: ., windows: ($windows[.]//0)})'
      }

      spaces
      ${lib.getExe pkgs.socat} -u UNIX-CONNECT:${hypr_sock} - | while read -r line; do
      	spaces
      done
    '')
  ];
}
