{ pkgs, ... }:
let
  session = "ssh-agent Hyprland";
  username = "yassine";
in
{
  imports = [
	  ./greetd.nix
	];
  # Enable automatic login for the user.
  # services.xserver.displayManager.autoLogin.enable = true;
  # services.xserver.displayManager.autoLogin.user = "yassine";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  # systemd.services."getty@tty1".enable = false;
  # systemd.services."autovt@tty1".enable = false;

  services.greetd = {
    settings = {
      initial_session = {
        command = "${session}";
        user = "${username}";
      };
    };
  };
}
