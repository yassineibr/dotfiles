{
  inputs,
  pkgs,
  ...
}: {
  nix.settings = {
    substituters = ["https://nix-community.cachix.org" "https://cache.ibrahimi.xyz"];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.ibrahimi.xyz:sJXcKBgYznXb0me/fndlO2l470PTBjeuNrV7/v5Fguk="
    ];
  };
}
