{
  wallpaper.enabled = false;
  # configure noctalia here
  bar = {
    density = "default";
    position = "top";
    showCapsule = false;
    widgets = {
      left = [
        {
          id = "ControlCenter";
          useDistroLogo = true;
        }
        {
          hideUnoccupied = false;
          id = "Workspace";
          labelMode = "none";
        }
      ];
      center = [
        {
          formatHorizontal = "HH:mm - dd/MM";
          formatVertical = "HH mm";
          id = "Clock";
          useMonospacedFont = true;
          usePrimaryColor = true;
        }
        {
          id = "plugin:mawaqit";
        }
      ];
      right = [
        {
          id = "Volume";
        }
        {
          id = "Network";
        }
        {
          id = "plugin:netbird";
        }
        {
          id = "Bluetooth";
        }
        {
          alwaysShowPercentage = false;
          id = "Battery";
          warningThreshold = 30;
        }
      ];
    };
  };
  colorSchemes.predefinedScheme = "Monochrome";
  # general = {
  # 	avatarImage = "/home/drfoobar/.face";
  # 	radiusRatio = 0.2;
  # };
  location = {
    monthBeforeDay = true;
    hideWeatherCityName = true;
    autoLocate = true;
  };
}
