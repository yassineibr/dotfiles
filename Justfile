default:
  @just --list

deploy:
    nixos-rebuild switch --flake . --use-remote-sudo

debug:
    nixos-rebuild switch --flake . --use-remote-sudo --show-trace --verbose

update:
    nix flake update

upgrade: update deploy

gc-profile:
    nix-collect-garbage -d

gc-system:
    sudo nix-collect-garbage -d

gc: gc-profile gc-system

fmt:
    nix fmt

