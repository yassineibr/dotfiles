{ pkgs, ... }:
{
  # lid switch
  services.logind.settings.Login = {
    # services.logind.lidSwitch = "ignore";
    HandleLidSwitch = "ignore";
    # services.logind.lidSwitchExternalPower = "ignore";
    HandlelidSwitchExternalPower = "ignore";
  };
}
