{ config
, lib
, pkgs
, ...
}: {
  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.anki = {
        enable = mkEnableOption "planet anki";
      };
    };

  config =
    let
      cfg = config.planet.feh;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      home.packages = with pkgs; [
        anki
      ];

      planet.persistence = {
        directories = [ ".local/share/Anki2" ];
      };
    };
}
