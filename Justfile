default:
  @just --list

boot host="":
    nixos-rebuild boot --flake .#{{host}} --sudo --show-trace --verbose

deploy host="":
    nixos-rebuild switch --flake .#{{host}} --sudo

debug host="":
    nixos-rebuild switch --flake .#{{host}} --sudo --show-trace --verbose

offline host="":
    nixos-rebuild switch --flake .#{{host}} --sudo --show-trace --verbose --offline

build host="":
    nixos-rebuild build --flake .#{{host}} --sudo --show-trace --verbose

test host="":
    nixos-rebuild test --flake .#{{host}} --sudo --show-trace --verbose

vm host="":
    sudo nixos-rebuild build-vm --flake .#{{host}} --sudo --show-trace --verbose
    sudo -E ./result/bin/run-*-vm
    sudo rm -f ./*.qcow2 ./result

update repo="":
    nix flake update {{repo}}

nvfetcher:
	cd overlays && nvfetcher
	just fmt
	git add overlays
	git diff --staged

upgrade: update deploy

gc-profile:
    nix-collect-garbage -d

gc-system:
    sudo nix-collect-garbage -d

gc: gc-profile gc-system

fmt:
    nix fmt

remote-debug host="":
    nixos-rebuild switch --flake .#{{host}} --sudo --show-trace --verbose --target-host {{host}}

remote-build host="":
    nixos-rebuild build --flake .#{{host}} --sudo --show-trace --verbose --target-host {{host}}

remote-test host="":
    nixos-rebuild test --flake .#{{host}} --sudo --show-trace --verbose --target-host {{host}}


sops-update-keys:
  sops updatekeys ./hosts/common/secrets.yml
