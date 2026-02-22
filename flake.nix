{
  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://cuda-maintainers.cachix.org"
      "https://attic.ibrahimi.xyz/system"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "system:51hbrsnX2pmCB3z3otgdnt2aq+konejsg/bQ7Qu1W+o="
    ];
  };

  description = "NixOS/Home-Manager Config Flake";

  inputs = {
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      # url = "github:nix-community/home-manager/master";
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
      # inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # HyprWM Flakes
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    hyprlock.url = "github:hyprwm/Hyprlock";

    hyprpaper.url = "github:hyprwm/hyprpaper";

    hyprgrass = {
      url = "github:horriblename/hyprgrass";
      inputs.hyprland.follows = "hyprland"; # IMPORTANT
    };

    # AGS
    matugen.url = "github:InioX/matugen?ref=v2.2.0";
    ags.url = "github:Aylur/ags";
    astal.url = "github:Aylur/astal";

    # Secure Boot
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.3";
      # inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    systems.url = "github:nix-systems/default-linux";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    deploy-rs.url = "github:serokell/deploy-rs";

  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      treefmt-nix,
      deploy-rs,
      ...
    }:
    let
      inherit (self) outputs;

      lib = nixpkgs.lib // home-manager.lib;
      systems = import inputs.systems;

      pkgsFor = lib.genAttrs systems (
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [
            outputs.overlays.unstable-packages
          ];
        }
      );

      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});

      # Eval the treefmt modules from ./shell/treefmt.nix
      treefmtEval = forEachSystem (pkgs: treefmt-nix.lib.evalModule pkgs ./shell/treefmt.nix);
    in
    {
      devShells = forEachSystem (pkgs: import ./shell.nix { inherit pkgs; });

      formatter = forEachSystem (
        pkgs: treefmtEval.${pkgs.stdenv.hostPlatform.system}.config.build.wrapper
      );

      homeConfigurations = import ./home/default.nix { inherit lib inputs pkgsFor; };

      # hydraJobs = import ./hydra.nix { inherit inputs outputs; };

      nixosConfigurations = import ./hosts/default.nix { inherit lib inputs outputs; };

      deploy = import ./deploy-rs/default.nix { inherit lib inputs outputs; };

      checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;

      overlays = import ./overlays { inherit inputs; };

      packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });

      templates = import ./templates;
    };
}
