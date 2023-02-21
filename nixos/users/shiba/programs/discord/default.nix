{ pkgs, ... }: {
  home.packages = with pkgs; [
    pers-pkgs.discord
  ];

  home.persistence."/persist/home/shiba".directories = [
    ".config/discord"
  ];
}
