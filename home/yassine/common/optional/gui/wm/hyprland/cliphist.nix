{
  inputs,
  pkgs,
  config,
  ...
}:
{
  home.packages = with pkgs; [
    (cliphist.overrideAttrs (_old: {
      src = pkgs.fetchFromGitHub {
        owner = "sentriz";
        repo = "cliphist";
        rev = "c49dcd26168f704324d90d23b9381f39c30572bd";
        sha256 = "sha256-2mn55DeF8Yxq5jwQAjAcvZAwAg+pZ4BkEitP6S2N0HY=";
      };
      vendorHash = "sha256-M5n7/QWQ5POWE4hSCMa0+GOVhEDCOILYqkSYIGoy/l0=";
    }))
  ];

  wayland.windowManager.hyprland = {
    settings = {
      exec-once = [
        "wl-paste --type text --watch cliphist store #Stores only text data"
        "wl-paste --type image --watch cliphist store #Stores only image data"
      ];
      bind = [
        "SUPER, V, exec, pkill rofi || cliphist list | rofi -dmenu | cliphist decode | wl-copy"
      ];
    };
  };
}
