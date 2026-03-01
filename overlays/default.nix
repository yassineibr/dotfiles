# This file defines overlays
{ inputs, ... }:
let
  generated = import ./_sources/generated.nix;
in
{
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs { pkgs = final; };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
  };

  nvfetcher = final: prev: {
    sources = generated {
      inherit (final)
        fetchurl
        fetchgit
        fetchFromGitHub
        dockerTools
        ;
    };
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: rec {
    _sources = generated {
      inherit (final)
        fetchurl
        fetchgit
        fetchFromGitHub
        dockerTools
        ;
    };

    unstable = import inputs.nixpkgs-unstable {
      system = final.stdenv.hostPlatform.system;
      config.allowUnfree = true;
    };

    netbird = _prev.netbird.overrideAttrs (oldAttrs: rec {
      inherit (_sources.netbird) src vendorHash;

      version = final.lib.strings.removePrefix "v" _sources.netbird.version;

      ldflags = [
        "-s"
        "-w"
        "-X github.com/netbirdio/netbird/version.version=${version}"
        "-X main.builtBy=nix"
      ];
    });
  };

}
