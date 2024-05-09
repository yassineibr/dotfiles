{ pkgs, ... }:
{
  services.cron = {
    enable = true;
    systemCronJobs = with pkgs; [
      ''
        */5 * * * *      yassine  DISPLAY=':1' DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"  ${dunst}/bin/dunstify -t 20000 "Health" "Look away from the screen"
      ''
    ];
  };
}
