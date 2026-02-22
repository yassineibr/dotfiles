# Shell for bootstrapping flake-enabled nix and other tooling
{
  pkgs ?
    # If pkgs is not defined, instanciate nixpkgs from locked commit
    let
      getLock = flake: (builtins.fromJSON (builtins.readFile ./flake.lock)).nodes.${flake}.locked;
      getTarBall =
        lock:
        fetchTarball {
          url = "https://github.com/nixos/nixpkgs/archive/${lock.rev}.tar.gz";
          sha256 = lock.narHash;
        };
      nixpkgs = getTarBall (getLock "nixpkgs");
      nixpkgs-unstable = getTarBall (getLock "nixpkgs-unstable");
    in
    import nixpkgs {
      overlays = [
        (final: _prev: {
          unstable = import nixpkgs-unstable {
            system = final.stdenv.hostPlatform.system;
            config.allowUnfree = true;
          };
        })
      ];
    },
  ...
}:
{
  ci = pkgs.mkShell {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes";
    nativeBuildInputs = with pkgs; [ attic-client ];
  };

  default = pkgs.mkShell {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes";
    nativeBuildInputs = with pkgs; [
      git
      nix
      home-manager
      unstable.nh

      # Secret management
      age
      ssh-to-age
      sops

      nvfetcher
      lazygit
      nh

      deploy-rs
    ];
  };
}
# awscli2
# opentofu
# act
