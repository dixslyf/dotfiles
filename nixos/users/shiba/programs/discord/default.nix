{ pkgs, ... }: {
  home.packages = with pkgs; [
    discord
  ];

  home.persistence."/persist/home/shiba".directories = [
    ".config/discord"
  ];
}
