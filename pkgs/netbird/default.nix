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
    version = "0.71.2";
  in
  {
    # pname = "netbird";
    inherit version;

    src = _pkgs.fetchFromGitHub {
      owner = "netbirdio";
      repo = "netbird";
      rev = "v${version}";
      hash = "sha256-rmm9NdWNjcEmUp84lad709EoVCZz19/5/N5ssflWzt4=";
    };

    vendorHash = "sha256-NeZuj9o2yu5di+6jbNqCnAw0fI55GA5Otmr77c08QFc=";

    ldflags = [
      "-s"
      "-w"
      "-X github.com/netbirdio/netbird/version.version=${version}"
      "-X main.builtBy=nix"
    ];

  }
)
