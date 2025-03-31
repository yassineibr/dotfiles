# Tree wide Formatting just run "nix fmt"
{ pkgs, ... }:
{
  # Used to find the project root
  projectRootFile = "flake.nix";

  # Format nix files
  # programs.alejandra.enable = true;
  programs.nixfmt.enable = true;
  # programs.nixfmt.package = pkgs.unstable.nixfmt-rfc-style;

  # Format markdown files
  programs.mdformat.enable = true;
}
