final: prev: {
  netbird = prev.netbird.overrideAttrs (
    oldAttrs:
    let
      version = "0.68.1";
    in
    {
      pname = "netbird";
      inherit version;

      src = prev.fetchFromGitHub {
        owner = "netbirdio";
        repo = "netbird";
        rev = "v${version}";
        hash = "sha256-2/TnyN/CGIRlXEH2KxYaEJL7Q7dm3mRe3/00gYxCebg=";
      };

      vendorHash = "sha256-NUdMiTPXgKb6vxF5odJ0MBBwatqA2SlN+0KR2Z8HoWM=";

      ldflags = [
        "-s"
        "-w"
        "-X github.com/netbirdio/netbird/version.version=${version}"
        "-X main.builtBy=nix"
      ];
    }
  );
}

# let
#   generated = import ./_sources/generated.nix;
# in
# nvfetcher = final: prev: {
#   sources = generated {
#     inherit (final)
#       fetchurl
#       fetchgit
#       fetchFromGitHub
#       dockerTools
#       ;
#   };
# };
# _sources = generated {
#   inherit (final)
#     fetchurl
#     fetchgit
#     fetchFromGitHub
#     dockerTools
#     ;
# };
# netbird = _prev.netbird.overrideAttrs (oldAttrs: rec {
#   inherit (_sources.netbird) src vendorHash;
#
#   version = final.lib.strings.removePrefix "v" _sources.netbird.version;
#
#   ldflags = [
#     "-s"
#     "-w"
#     "-X github.com/netbirdio/netbird/version.version=${version}"
#     "-X main.builtBy=nix"
#   ];
# });
