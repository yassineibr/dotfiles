{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    sshs
  ];

  home.shellAliases = {
    "s" = "sshs -e";
  };
}
