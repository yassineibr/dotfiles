{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    # nerdfonts
    font-awesome
    source-sans-pro
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only

  ];
}
