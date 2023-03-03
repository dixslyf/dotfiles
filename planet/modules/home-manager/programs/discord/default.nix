{ pkgs
, ...
}: {
  home.packages = with pkgs; [ discord ];
  planet.persistence = {
    directories = [ ".config/discord" ];
  };
}
