{ outputs, inputs, ... }:
{
  nixpkgs.overlays = [
    outputs.overlays.unstable-packages
    inputs.hyprpanel.overlay
  ];
}
