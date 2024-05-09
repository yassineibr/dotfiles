{
  inputs,
  pkgs,
  ...
}: {
  nix.settings = {
    substituters = [
      "https://nix-community.cachix.org"
      "https://cache.ibrahimi.xyz"
      "https://cuda-maintainers.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.ibrahimi.xyz:sJXcKBgYznXb0me/fndlO2l470PTBjeuNrV7/v5Fguk="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
    ];
  };
}
