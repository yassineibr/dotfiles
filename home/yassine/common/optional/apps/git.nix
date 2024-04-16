{
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    userName = "yassineibr";
    userEmail = "75940849+yassineibr@users.noreply.github.com";
    extraConfig = {
      # Sign all commits using ssh key
      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = "~/.ssh/id_git.pub";
    };
  };
}
