{
  lib,
  inputs,
  pkgsFor,
  ...
}: {
  yassine = lib.homeManagerConfiguration {
    pkgs = pkgsFor.x86_64-linux;
    extraSpecialArgs = {inherit inputs;};
    modules = [];
  };
}
