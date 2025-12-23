{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [ inputs.nixvim.packages.${pkgs.stdenv.hostPlatform.system}.default ];

  home.shellAliases = {
    "vi" = "nvim";
    "vim" = "nvim";
  };

  programs.ripgrep.enable = true;
}
