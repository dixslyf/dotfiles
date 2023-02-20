{ pkgs, ... }: {
  home.packages = with pkgs; [ yuzu-mainline ];
  home.persistence."/persist/home/shiba".directories = [
    ".config/yuzu"
    ".local/share/yuzu"
  ];
}
