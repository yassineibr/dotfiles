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
    version = "0.79.0";
  in
  {
    # pname = "netbird";
    inherit version;

    src = _pkgs.fetchFromGitHub {
      owner = "netbirdio";
      repo = "netbird";
      rev = "v${version}";
      hash = "sha256-Bi83uh8VKvFGUY+AxP34VCXYxpZI1C/oOa6eHmKXpDw=";
    };

    vendorHash = "sha256-+JwuUz8msyoiPUTz8cH3vn9DrvLp6gaM2NqFuTOcRdg=";

    ldflags = [
      "-s"
      "-w"
      "-X github.com/netbirdio/netbird/version.version=${version}"
      "-X main.builtBy=nix"
    ];

  }
)
