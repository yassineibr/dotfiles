{ config, pkgs, ... }:
{
  programs.bash = {
    enable = true;
    historyFile = "${config.xdg.dataHome}/bash/history";
  };
}
