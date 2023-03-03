{ pkgs
, ...
}: {
  home.packages = with pkgs; [ osu-lazer-bin ];
  planet.persistence = {
    directories = [ ".local/share/osu" ];
  };
}
