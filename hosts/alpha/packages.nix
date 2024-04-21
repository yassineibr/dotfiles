{pkgs, ...}: {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    sshfs
    distrobox
    virtiofsd
    vim
    wget
    # neovim
    brave
    piper
    libgccjit
    git
    gnupg
    kitty

    pinentry-curses
    # networkmanager-openvpn
    waypipe
  ];
}
