{
  lib,
  inputs,
  ...
}: {
  # MSI Laptop
  alpha = lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {inherit inputs;};
    modules = [];
  };

  # HP Laptop
  beta = lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {inherit inputs;};
    modules = [
      ./beta
    ];
  };
}
