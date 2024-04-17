{inputs, ...}: {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = 300;
        height = 200;
        offset = "30x50";
        origin = "top-center";
        transparency = 0;
        padding = 20;
        horizontal_padding = 20;
        # frame_color = config.theme.colors.base03;
        font = "Droid Sans 13";
        corner_radius = 10;
      };

      urgency_normal = {
        # background = config.theme.colors.base00;
        # foreground = config.theme.colors.base05;
        timeout = 10;
      };
    };
  };
}
