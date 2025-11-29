{ pkgs, ... }:
let
  tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
  session = "ssh-agent Hyprland";
in
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${tuigreet} --greeting 'Welcome to NixOS!' --asterisks --remember --remember-user-session --time -cmd ${session}";
        user = "greeter";
      };
    };
  };
}
