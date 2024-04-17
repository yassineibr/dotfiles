{
  description = "NixOS/Home-Manager Config Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixVim
    nix-vim.url = "github:yassineibr/nixvim";

    # HyprWM Flakes
    hyprland.url = "github:hyprwm/Hyprland";

    hyprlock.url = "github:hyprwm/Hyprlock";

    hyprpaper.url = "github:hyprwm/hyprpaper";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    treefmt-nix,
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

    # Eval the treefmt modules from ./treefmt.nix
    treefmtEval =
      forEachSystem (pkgs: treefmt-nix.lib.evalModule pkgs ./treefmt.nix);
  in {
    devShells = forEachSystem (pkgs: import ./shell.nix {inherit pkgs;});

    formatter =
      forEachSystem (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);

    homeConfigurations =
      import ./home/default.nix {inherit lib inputs pkgsFor;};

    nixosConfigurations = import ./hosts/default.nix {inherit lib inputs;};
  };
}
