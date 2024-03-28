{lib, inputs, ...}:{
  # MSI Laptop
  dragon = lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {inherit inputs;};
    modules = [];
  };
}
