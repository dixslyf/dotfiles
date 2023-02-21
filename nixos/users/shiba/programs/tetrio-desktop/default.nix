{ pkgs, ... }: {
  home.packages = with pkgs; [ (pkgs.tetrio-desktop.override { withTetrioPlus = true; }) ];
  home.persistence."/persist/home/shiba".directories = [ ".config/tetrio-desktop" ];
}
