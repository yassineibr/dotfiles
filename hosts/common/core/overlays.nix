{outputs, ...}: {
  nixpkgs.overlays = [outputs.overlays.unstable-packages];
}
