{
  pkgs ? import <nixpkgs> { },
  inputs,
  ...
}:
let
  _pkgs = import inputs.nixpkgs {
    system = pkgs.stdenv.hostPlatform.system;
  };
in
_pkgs.netbird.overrideAttrs (
  oldAttrs:
  let
    version = "0.72.1";
  in
  {
    # pname = "netbird";
    inherit version;

    src = _pkgs.fetchFromGitHub {
      owner = "netbirdio";
      repo = "netbird";
      rev = "v${version}";
      hash = "sha256-f78zf6uihFyz4H8/ZXk2rfO8nln+HMNIV5/yQHRpdQI=";
    };

    vendorHash = "sha256-gxSf2X7IsZecvfM2xGE5Y1jZgvaKaRG780MRkZKFkHg=";

    ldflags = [
      "-s"
      "-w"
      "-X github.com/netbirdio/netbird/version.version=${version}"
      "-X main.builtBy=nix"
    ];

  }
)
