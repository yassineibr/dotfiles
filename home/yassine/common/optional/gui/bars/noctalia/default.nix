{ pkgs, inputs, ... }:
{
  imports = [
    inputs.noctalia.homeModules.default
    ./plugins.nix
  ];

  # configure options
  programs.noctalia-shell = {
    enable = true;
    # package = (
    #   inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
    #     calendarSupport = true;
    #   }
    # );
    settings = import ./settings.nix;
    # this may also be a string or a path to a JSON file.
  };
}
