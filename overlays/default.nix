# This file defines overlays
{ inputs, ... }:
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

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };

    netbird = _prev.netbird.overrideAttrs (oldAttrs: rec {
      version = "0.40.0";

      src = _prev.fetchFromGitHub {
        owner = "netbirdio";
        repo = "netbird";
        rev = "v${version}";
        sha256 = "sha256-GbKA6tJLCQNCiG9rj3iW4l51nQEbt42u7B6tFCbDSTQ=";
      };

      vendorHash = "sha256-vy725OvkYLyCDYEmnPpXJWqyofb29GiP4GkLn1GInm0=";

      ldflags = [
        "-s"
        "-w"
        "-X github.com/netbirdio/netbird/version.version=${version}"
        "-X main.builtBy=nix"
      ];
    });
  };

}
