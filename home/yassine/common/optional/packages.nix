{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    attic-client

    signal-desktop-bin
    discord

    evince
    # kdePackages.okular
    alejandra
    spotify
    # nixops_unstable

    just
    keepassxc
    bitwarden-desktop
    bitwarden-cli
    imv
    lf

    podman-compose
    htop-vim
    gdu
    vscode
    tealdeer
    obs-studio
    wireshark
    zellij
    tmux
    moonlight-qt

    vlc
  ];
}
