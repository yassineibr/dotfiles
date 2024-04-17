{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    evince
    okular
    alejandra
    spotify
    nixops_unstable

    just
    keepassxc
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
    moonlight-qt

    vlc
  ];
}
