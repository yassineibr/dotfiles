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
    version = "0.70.5";
  in
  {
    # pname = "netbird";
    inherit version;

    src = _pkgs.fetchFromGitHub {
      owner = "netbirdio";
      repo = "netbird";
      rev = "v${version}";
      hash = "sha256-AsM+MEeBqxnwD1jE8ocI93tF3l/7s+s5nF073ZMAi/Y=";
    };

    vendorHash = "sha256-ebhjN6o/519ayxWTcscNinKuiL3LSPmE2VNgSitxj5g=";

    ldflags = [
      "-s"
      "-w"
      "-X github.com/netbirdio/netbird/version.version=${version}"
      "-X main.builtBy=nix"
    ];

  }
)
