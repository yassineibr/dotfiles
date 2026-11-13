{ inputs, pkgs, ... }:
{

  nix.settings = {
    substituters = [
      "https://nix-community.cachix.org"
      "https://cache.nixos-cuda.org"
      "https://attic.ibrahimi.xyz/system"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
      "system:51hbrsnX2pmCB3z3otgdnt2aq+konejsg/bQ7Qu1W+o="
    ];
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };
}
