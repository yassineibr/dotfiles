{pkgs, ...}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.yassine = {
    isNormalUser = true;
    description = "yassine";
    shell = pkgs.zsh;
    extraGroups = ["video" "networkmanager" "wheel"];
  };
}
