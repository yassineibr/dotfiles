{ config, pkgs, ... }:
{
  programs.eza = {
    enable = true;

    enableBashIntegration = true;
    enableZshIntegration = true;
    # enableAliases = true;
    icons = "auto";

    extraOptions = [ "--group-directories-first" ];
  };

  home.shellAliases = {
    "tree" = "eza --tree";
  };
}
