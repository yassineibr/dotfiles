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

  # Thinkpad M710q I7
  gamma = lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {
      inherit inputs outputs;
    };
    modules = [ ./gamma ];
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
