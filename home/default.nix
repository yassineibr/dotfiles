{
  lib,
  inputs,
  pkgsFor,
  ...
}:
{
  "yassine@alpha" = lib.homeManagerConfiguration {
    pkgs = pkgsFor.x86_64-linux;
    extraSpecialArgs = {
      inherit inputs;
    };
    modules = [ ./yassine/alpha.nix ];
  };

  "yassine@beta" = lib.homeManagerConfiguration {
    pkgs = pkgsFor.x86_64-linux;
    extraSpecialArgs = {
      inherit inputs;
    };
    modules = [ ./yassine/beta.nix ];
  };
}
