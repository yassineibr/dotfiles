{ pkgs, ... }:
{
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
    # waypipe

    heroic

		openbao
		jq

    # pkgs.stable.bitwarden-desktop
    # pkgs.stable.bitwarden-desktop
    bitwarden-desktop
  ];

  # nixpkgs.config.permittedInsecurePackages = [
  #   "electron-39.8.10"
  # ];

}
