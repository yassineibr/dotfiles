{ config, pkgs, ... }:
{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
    };
  };

  programs.carapace = {
    enable = true;

    enableNushellIntegration = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };

  programs.nushell = {
    enable = true;
    plugins = with pkgs.nushellPlugins; [
      gstat
    ];

    settings = {
      show_banner = false;
      # completions.external = {
      #   enable = true;
      #   max_results = 200;
      # };
    };
  };
}
