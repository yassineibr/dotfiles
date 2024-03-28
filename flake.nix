{
  description = "NixOS/Home-Manager Config Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }: let
    lib = nixpkgs.lib;
    systems = ["x86_64-linux" "aarch64-linux"];

    pkgsFor = lib.genAttrs systems (system:
      import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      });

    forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
  in {
    formatter = forEachSystem (pkgs: pkgs.alejandra);

    devShells = forEachSystem (pkgs: import ./shell.nix {inherit pkgs;});

    nixosConfigurations = import ./hosts/default.nix { inherit lib inputs;} ;
  };
}
