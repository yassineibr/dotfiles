default:
  @just --list

deploy host="":
    nixos-rebuild switch --flake .#{{host}} --use-remote-sudo

debug host="":
    nixos-rebuild switch --flake .#{{host}} --use-remote-sudo --show-trace --verbose

build host="":
    nixos-rebuild build --flake .#{{host}} --use-remote-sudo --show-trace --verbose

test host="":
    nixos-rebuild test --flake .#{{host}} --use-remote-sudo --show-trace --verbose

boot host="":
    nixos-rebuild boot --flake .#{{host}} --use-remote-sudo --show-trace --verbose

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

