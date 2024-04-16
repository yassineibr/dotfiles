{
  programs.kitty = {
    enable = true;
    shellIntegration.enableBashIntegration = true;
    shellIntegration.enableZshIntegration = true;

    extraConfig = "background_opacity 0.85";
    font = {
      name = "JetBrainsMono Bold";
      size = 12;
    };
  };
}
