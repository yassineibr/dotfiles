{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (pkgs) writeText;
  inherit (lib.strings) concatStringsSep;
  inherit (config) xdg;
in {
  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "x-scheme-handler/pttp" = ["cisco-pt8.desktop.desktop"];
    };
    defaultApplications = {
      "x-scheme-handler/pttp" = ["cisco-pt8.desktop.desktop"];
    };
  };
  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    # Work around firefox creating a "Desktop" directory
    desktop = "${config.home.homeDirectory}/Desktop";
    download = "${config.home.homeDirectory}/Downloads";
    documents = "${config.home.homeDirectory}/Documents";
    music = "${config.home.homeDirectory}/Music";
    videos = "${config.home.homeDirectory}/Videos";
    pictures = "${config.home.homeDirectory}/Pictures";
    publicShare = "${config.home.homeDirectory}/Public";
    templates = "${config.home.homeDirectory}/Templates";
    extraConfig = {
      XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
    };
  };

  home.sessionVariables = {
    _JAVA_OPTIONS = concatStringsSep " " [
      "-Djava.util.prefs.userRoot='${xdg.configHome}'/java"
      "-Djavafx.cachedir='${xdg.cacheHome}/openjfx'"
    ];
    LESSKEY = "${xdg.cacheHome}/less/key";
    LESSHISTFILE = "${xdg.cacheHome}/less/history";
    PYLINTHOME = "${xdg.cacheHome}/pylint";
    CARGO_HOME = "${xdg.cacheHome}/cargo";
    RUSTUP_HOME = "${xdg.dataHome}/rustup";
    XCOMPOSECACHE = "${xdg.cacheHome}/X11/xcompose";
    XCOMPOSEFILE = "${xdg.configHome}/X11/xcompose";
    MAILCAPS = "${xdg.configHome}/mailcap";
    IPYTHONDIR = "${xdg.dataHome}/ipython";
    JUPYTER_CONFIG_DIR = "${xdg.dataHome}/ipython";
    HISTFILE = "${xdg.dataHome}/histfile";
    RLWRAP_HOME = "${xdg.dataHome}/rlwrap";
    CUDA_CACHE_PATH = "${xdg.dataHome}/cuda";
    DOCKER_CONFIG = "${xdg.configHome}/docker";
    NODE_REPL_HISTORY = "${xdg.dataHome}/node_repl_history";
    PARALLEL_HOME = "${xdg.configHome}/parallel";
    MPLAYER_HOME = "${xdg.configHome}/mplayer";

    GRADLE_USER_HOME = "${xdg.cacheHome}/gradle";

    NPM_CONFIG_USERCONFIG = writeText "npmrc" ''
      prefix=${xdg.cacheHome}/npm
      cache=${xdg.cacheHome}/npm
      tmp=$XDG_RUNTIME_DIR/npm
      init-module=${xdg.configHome}/npm/config/npm-init.js
    '';

    PYTHONSTARTUP = "${xdg.configHome}/python/pythonrc";

    EDITOR = "nvim";
  };

  home.file.${config.home.sessionVariables.PYTHONSTARTUP}.source = writeText "pythonrc" ''
import os
import atexit
import readline

history = os.path.join(os.environ['XDG_CACHE_HOME'], 'python_history')
try:
    readline.read_history_file(history)
except OSError:
    pass

def write_history():
    try:
        readline.write_history_file(history)
    except OSError:
        pass

atexit.register(write_history)
    '';

}
