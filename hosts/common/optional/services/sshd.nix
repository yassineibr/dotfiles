{ pkgs, lib, ... }:
{
  services.openssh = {
    enable = true;
    # require public key authentication for better security
    settings = {
      PasswordAuthentication = lib.mkDefault false;
      KbdInteractiveAuthentication = false;
      X11Forwarding = true;
    };
    #settings.PermitRootLogin = "yes";
  };

  # Passwordless sudo when SSH'ing with keys
  # security.pam.services.sudo =
  #   { config, ... }:
  #   {
  #     rules.auth.rssh = {
  #       order = config.rules.auth.ssh_agent_auth.order - 1;
  #       control = "sufficient";
  #       modulePath = "${pkgs.pam_rssh}/lib/libpam_rssh.so";
  #       settings.authorized_keys_command = pkgs.writeShellScript "get-authorized-keys" ''
  #         cat "/etc/ssh/authorized_keys.d/$1"
  #       '';
  #     };
  #   };
  # Keep SSH_AUTH_SOCK when sudo'ing
  security.sudo.extraConfig = ''
    Defaults env_keep+=SSH_AUTH_SOCK
  '';
}
