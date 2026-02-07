{
  lib,
  inputs,
  outputs,
  ...
}:
{
  # MSI Laptop
  alpha = lib.nixosSystem {
    specialArgs = {
      inherit inputs outputs;
    };
    modules = [ ./alpha ];
  };

  # HP Laptop
  beta = lib.nixosSystem {
    specialArgs = {
      inherit inputs outputs;
    };
    modules = [ ./beta ];
  };

  # Thinkpad M710q I7
  gamma = lib.nixosSystem {
    specialArgs = {
      inherit inputs outputs;
    };
    modules = [ ./gamma ];
  };


  theta = lib.nixosSystem {
    specialArgs = {
      inherit inputs outputs;
    };
    modules = [ ./theta ];
  };

  # Desktop
  omega = lib.nixosSystem {
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
