{pkgs,...}:{
  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = ["FiraCode" "DroidSansMono" "JetBrainsMono" "NerdFontsSymbolsOnly"];
    })
    # nerdfonts
    font-awesome
  ];
}
