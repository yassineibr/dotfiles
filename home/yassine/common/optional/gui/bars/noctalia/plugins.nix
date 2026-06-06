{ ... }:
{
  # configure options
  programs.noctalia-shell = {
    plugins = {
      sources = [
        {
          enabled = true;
          name = "Official Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
        }
      ];

      states = {
        netbird = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        mawaqit = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
      };
      version = 2;
    };
    # this may also be a string or a path to a JSON file.

    pluginSettings = {
      netbird = {
        refreshInterval = 5000;
        compactMode = true;
        showIpAddress = false;
        hideDisconnected = false;
        showPing = false;
        terminalCommand = "";
        pingCount = 5;
        defaultPeerAction = "copy-ip";
        managementUrl = "";
      };
      # this may also be a string or a path to a JSON file.
    };
  };
}
