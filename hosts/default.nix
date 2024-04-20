{
  lib,
  inputs,
  outputs,
  ...
}: {
  # MSI Laptop
  alpha = lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {inherit inputs outputs;};
    modules = [];
  };

  # HP Laptop
  beta = lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {inherit inputs outputs;};
    modules = [
      ./beta
    ];
  };
}
