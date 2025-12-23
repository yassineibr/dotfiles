{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "yassineibr";
        email = "75940849+yassineibr@users.noreply.github.com";
      };
      # Sign all commits using ssh key
      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = "~/.ssh/id_git.pub";
    };

    includes = [
      {
        condition = "gitdir:~/work/";
        path = "/home/yassine/.config/git/config.work";
      }
    ];
  };
}
