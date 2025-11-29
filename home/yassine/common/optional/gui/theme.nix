{ config, pkgs, ... }:
{
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  # home.sessionVariables = {
  #   GTK_THEME = config.gtk.theme.name;
  # };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;

    # theme = {
    #   name = "adw-gtk3-dark";
    #   package = pkgs.adw-gtk3;
    # };
    #
    # iconTheme.package = pkgs.adwaita-icon-theme;
    # iconTheme.name = "Adwaita";

    gtk3 = {
      extraConfig = {
        Settings = ''
          gtk-application-prefer-dark-theme=1
        '';
      };
    };

    gtk4 = {
      extraConfig = {
        Settings = ''
          gtk-application-prefer-dark-theme=1
        '';
      };
    };
  };

  qt = {
    enable = true;
    # platform theme "gtk" or "gnome"
    platformTheme.name = "adwaita";

    # name of the qt theme
    style.name = "Adwaita-dark";

    # detected automatically:
    # adwaita, adwaita-dark, adwaita-highcontrast,
    # adwaita-highcontrastinverse, breeze,
    # bb10bright, bb10dark, cde, cleanlooks,
    # gtk2, motif, plastique

    # package to use
    style.package = pkgs.adwaita-qt;
  };
}
