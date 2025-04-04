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
      version = "0.39.2";

      src = _prev.fetchFromGitHub {
        owner = "netbirdio";
        repo = "netbird";
        rev = "v${version}";
        # sha256 = "sha256-Tm7MIgLfPbt3MFetYebYW+aeOgg55+lBXU1rXRIDfms=";
        sha256 = "sha256-K1qnQfkptMFviWWqzDA+yju/L/aMNTyO3qDHzMJnXzU=";
      };

      vendorHash = "sha256-yNFyW1D2gFkt2VDTyiaDXPw0zrT4KBQTe72x0Jh0jOs=";

      ldflags = [
        "-s"
        "-w"
        "-X github.com/netbirdio/netbird/version.version=${version}"
        "-X main.builtBy=nix"
      ];
    });
  };

}
