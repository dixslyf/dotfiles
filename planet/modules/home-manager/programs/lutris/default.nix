{ pkgs
, ...
}: {
  home.packages = with pkgs; [ lutris ];
  planet.persistence = {
    directories = [
      ".config/lutris"
      ".local/share/lutris"
    ];
  };
}
