{
  config,
  pkgs,
  lib,
  ...
}:
{
  # Setting RTC time standard to localtime, compatible with Windows in its default configuration
  time.hardwareClockInLocalTime = true;

  users.users.yassine = {
    packages = with pkgs; [
      # (pkgs.writeShellScriptBin "winboot" ''
      #   sudo ${pkgs.grub2}/bin/grub-reboot 2 && sudo ${pkgs.systemd}/bin/reboot
      # '')
      (pkgs.writeShellScriptBin "winboot" ''
        windows_hex=$(${pkgs.efibootmgr}/bin/efibootmgr | grep Windows | awk '{ print $1 }' | sed "s/Boot\([0-9A-Z]*\)\*\?/\1/")
        sudo ${pkgs.efibootmgr}/bin/efibootmgr --bootnext $windows_hex && sudo ${pkgs.systemd}/bin/reboot
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
            options = [ "NOPASSWD" ];
          }
          {
            command = "${pkgs.efibootmgr}/bin/efibootmgr";
            options = [ "NOPASSWD" ];
          }
        ];
        groups = [ "wheel" ];
      }
    ];
  };
}
