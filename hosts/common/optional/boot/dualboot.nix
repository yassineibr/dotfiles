{
  config,
  pkgs,
  lib,
  ...
}: {
  # Setting RTC time standard to localtime, compatible with Windows in its default configuration
  time.hardwareClockInLocalTime = true;

  users.users.yassine = {
    packages = with pkgs; [
      # (pkgs.writeShellScriptBin "winboot" ''
      #   sudo ${pkgs.grub2}/bin/grub-reboot 2 && sudo ${pkgs.systemd}/bin/reboot
      # '')
      (pkgs.writeShellScriptBin "winboot" ''
        sudo ${pkgs.efibootmgr}/bin/efibootmgr --bootnext 0000 && sudo ${pkgs.systemd}/bin/reboot
      '')
    ];
  };

  security.sudo = {
    enable = true;
    extraRules = [
      {
        commands = [
          {
            command = "${pkgs.systemd}/bin/reboot";
            options = ["NOPASSWD"];
          }
          {
            command = "${pkgs.efibootmgr}/bin/efibootmgr";
            options = ["NOPASSWD"];
          }
        ];
        groups = ["wheel"];
      }
    ];
  };
}
