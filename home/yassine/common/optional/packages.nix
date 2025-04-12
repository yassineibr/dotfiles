{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    attic-client
    yazi

    signal-desktop
    discord

    evince
    # kdePackages.okular
    alejandra
    spotify
    # nixops_unstable

    just
    keepassxc
    bitwarden
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
