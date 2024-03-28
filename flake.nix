{
  description = "NixOS/Home-Manager Config Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    ...
  }: let
    lib = nixpkgs.lib // home-manager.lib;
    systems = ["x86_64-linux"];

    pkgsFor = lib.genAttrs systems (system:
      import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      });

    forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
  in {
    devShells = forEachSystem (pkgs: import ./shell.nix {inherit pkgs;});

    formatter = forEachSystem (pkgs: pkgs.alejandra);

    homeConfigurations = import ./home/default.nix {inherit lib inputs pkgsFor;};

    nixosConfigurations = import ./hosts/default.nix {inherit lib inputs;};
  };
}
