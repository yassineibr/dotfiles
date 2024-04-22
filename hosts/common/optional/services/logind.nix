{pkgs, ...}: {
  # lid switch
  services.logind.lidSwitch = "ignore";
  services.logind.lidSwitchExternalPower = "ignore";
  services.logind.extraConfig = "HandleLidSwitch=ignore";
}
