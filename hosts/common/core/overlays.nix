{ outputs, inputs, ... }:
{
  nixpkgs.overlays = [
    outputs.overlays.unstable-packages
  ];
}
