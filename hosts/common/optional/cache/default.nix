{ inputs, pkgs, ... }:
{
  nix.settings = {
    substituters = [
      "https://nix-community.cachix.org"
      "https://cuda-maintainers.cachix.org"
      "https://attic.ibrahimi.xyz/system"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "system:51hbrsnX2pmCB3z3otgdnt2aq+konejsg/bQ7Qu1W+o="
    ];
  };
}
