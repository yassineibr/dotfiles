default:
  @just --list

boot host="":
    nixos-rebuild boot --flake .#{{host}} --use-remote-sudo --show-trace --verbose

deploy host="":
    nixos-rebuild switch --flake .#{{host}} --use-remote-sudo

debug host="":
    nixos-rebuild switch --flake .#{{host}} --use-remote-sudo --show-trace --verbose

build host="":
    nixos-rebuild build --flake .#{{host}} --use-remote-sudo --show-trace --verbose

test host="":
    nixos-rebuild test --flake .#{{host}} --use-remote-sudo --show-trace --verbose

vm host="":
    sudo nixos-rebuild build-vm --flake .#{{host}} --use-remote-sudo --show-trace --verbose
    sudo -E ./result/bin/run-*-vm
    sudo rm -f ./*.qcow2 ./result

update:
    nix flake update

nvfetcher:
	cd overlays && nvfetcher
	just fmt
	git add overlays

upgrade: update deploy

gc-profile:
    nix-collect-garbage -d

gc-system:
    sudo nix-collect-garbage -d

gc: gc-profile gc-system

fmt:
    nix fmt

remote-debug host="":
    nixos-rebuild switch --flake .#{{host}} --use-remote-sudo --show-trace --verbose --target-host {{host}}

remote-build host="":
    nixos-rebuild build --flake .#{{host}} --use-remote-sudo --show-trace --verbose --target-host {{host}}

remote-test host="":
    nixos-rebuild test --flake .#{{host}} --use-remote-sudo --show-trace --verbose --target-host {{host}}


sops-update-keys:
  sops updatekeys ./hosts/common/secrets.yml
