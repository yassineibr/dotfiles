{ config, ... }:
{
  sops.secrets.nix-access-tokens-github = { };

  # nix Flakes
  nix.extraOptions = ''
    !include ${config.sops.secrets.nix-access-tokens-github.path}
  '';
}
