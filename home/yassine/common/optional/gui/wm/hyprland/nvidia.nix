{
  inputs,
  pkgs,
  config,
  ...
}:
{
  wayland.windowManager.hyprland = {
    settings = {
      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        # "WLR_DRM_DEVICES,/dev/dri/card1:/dev/dri/card0"
      ];
    };
  };
}
