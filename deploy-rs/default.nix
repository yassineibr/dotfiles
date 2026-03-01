{
  lib,
  inputs,
  outputs,
  ...
}:
let
  mkDeploy =
    {
      host,
      arch ? "x86_64-linux",
      sshUser ? "yassine",
    }:
    {
      hostname = host;
      fastConnection = true;
      interactiveSudo = true;
      profiles.system = with inputs; {
        user = "root";
        sshUser = sshUser;
        path = inputs.deploy-rs.lib.${arch}.activate.nixos self.nixosConfigurations.${host};
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
