{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    inputs.nixvim.packages.${pkgs.system}.default
  ];

  home.shellAliases = {
    "vi" = "nvim";
    "vim" = "nvim";
  };
}
