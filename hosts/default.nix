{
  lib,
  inputs,
  outputs,
  ...
}:
{
  # MSI Laptop
  alpha = lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {
      inherit inputs outputs;
    };
    modules = [ ./alpha ];
  };

  # HP Laptop
  beta = lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {
      inherit inputs outputs;
    };
    modules = [ ./beta ];
  };

  # Desktop
  omega = lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {
      inherit inputs outputs;
    };
    modules = [ ./omega ];
  };

  epsilon = lib.nixosSystem {
    system = "aarch64-linux";
    specialArgs = {
      inherit inputs outputs;
    };
    modules = [ ./epsilon ];
  };
}
