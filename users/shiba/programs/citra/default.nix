{ pkgs, ... }: {
  home.packages = with pkgs; [ citra-nightly ];
  home.persistence."/persist/home/shiba".directories = [
    ".config/citra-emu"
    ".local/share/citra-emu"
  ];
}
