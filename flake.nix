{
  description = "NixOS/Home-Manager Config Flake";

  inputs = {
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

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
    nixvim = {
      url = "github:yassineibr/nixvim";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # HyprWM Flakes
    # hyprland.url = "github:hyprwm/Hyprland/ef23ef60c5641c5903f9cf40571ead7ad6aba1b9";
    # hyprland.url = "github:hyprwm/Hyprland";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    hyprlock.url = "github:hyprwm/Hyprlock";

    hyprpaper.url = "github:hyprwm/hyprpaper";

    hyprgrass = {
      url = "github:horriblename/hyprgrass";
      inputs.hyprland.follows = "hyprland"; # IMPORTANT
    };

    # Secure Boot
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.3.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      treefmt-nix,
      ...
    }:
    let
      inherit (self) outputs;

      lib = nixpkgs.lib // home-manager.lib;
      systems = [ "x86_64-linux" ];

      pkgsFor = lib.genAttrs systems (
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [ outputs.overlays.unstable-packages ];
        }
      );

      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});

      # Eval the treefmt modules from ./shell/treefmt.nix
      treefmtEval = forEachSystem (pkgs: treefmt-nix.lib.evalModule pkgs ./shell/treefmt.nix);
    in
    {
      devShells = forEachSystem (pkgs: import ./shell.nix { inherit pkgs; });

      formatter = forEachSystem (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);

      homeConfigurations = import ./home/default.nix { inherit lib inputs pkgsFor; };

      hydraJobs = import ./hydra.nix { inherit inputs outputs; };

      nixosConfigurations = import ./hosts/default.nix { inherit lib inputs outputs; };

      overlays = import ./overlays { inherit inputs; };

      packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });

      templates = import ./templates;
    };
}
