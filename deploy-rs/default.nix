{
  lib,
  inputs,
  outputs,
  ...
}:
let
  mkDeploy = host: {
    hostname = host;
    fastConnection = true;
    interactiveSudo = true;
    profiles.system = with inputs; {
      user = "root";
      path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.${host};
    };
  };
in
{
  nodes = {
    theta = mkDeploy "theta";
    gamma = mkDeploy "gamma";
    upsilon = mkDeploy "upsilon";
  };
}
