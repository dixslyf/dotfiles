{ pkgs
, ...
}: {
  home.packages = with pkgs; [ osu-lazer-bin ];
  home.persistence."/persist/home/shiba".directories = [ ".local/share/osu" ];
}
