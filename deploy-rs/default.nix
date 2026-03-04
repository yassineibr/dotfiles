{
  lib,
  inputs,
  outputs,
  ...
}:
let
  systems = import inputs.systems;
  # nixpkgs with deploy-rs overlay but force the nixpkgs package
  deployPkgsFor = lib.genAttrs systems (
    system:
    let
      pkgs = import inputs.nixpkgs {
        inherit system;
      };
    in
    import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        inputs.deploy-rs.overlays.default
        (self: super: {
          deploy-rs = {
            inherit (pkgs) deploy-rs;
            lib = super.deploy-rs.lib;
          };
        })
      ];
    }
  );

  mkDeploy =
    {
      host,
      arch ? "x86_64-linux",
      sshUser ? "yassine",
    }:
    {
      hostname = host;
      fastConnection = true;
      # interactiveSudo = true;
      profiles.system = with inputs; {
        user = "root";
        sshUser = sshUser;
        path = deployPkgsFor.${arch}.deploy-rs.lib.activate.nixos self.nixosConfigurations.${host};
      };
    };
in
{
  nodes = {
    theta = mkDeploy { host = "theta"; };
    gamma = mkDeploy { host = "gamma"; };
    upsilon = mkDeploy { host = "upsilon"; };
    epsilon = mkDeploy {
      host = "epsilon";
      arch = "aarch64-linux";
    };
  };
}
