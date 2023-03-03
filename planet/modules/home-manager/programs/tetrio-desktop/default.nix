{ pkgs
, ...
}: {
  home.packages = with pkgs; [ (tetrio-desktop.override { withTetrioPlus = true; }) ];
  planet.persistence = {
    directories = [ ".config/tetrio-desktop" ];
  };
}
