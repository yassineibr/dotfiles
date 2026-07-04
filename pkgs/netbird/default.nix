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
    version = "0.74.2";
  in
  {
    # pname = "netbird";
    inherit version;

    src = _pkgs.fetchFromGitHub {
      owner = "netbirdio";
      repo = "netbird";
      rev = "v${version}";
      hash = "sha256-+BGWZzw6a8Fp8NlhtbX81OA3hCTcQ9r6nLuXTsbXCZ8=";
    };

    vendorHash = "sha256-5dZu6lmfwaUHusAlFS1qqorFbpa4anCUQDtg4Tv5mxw=";

    ldflags = [
      "-s"
      "-w"
      "-X github.com/netbirdio/netbird/version.version=${version}"
      "-X main.builtBy=nix"
    ];

  }
)
