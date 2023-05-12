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
      planet.osu-lazer = {
        enable = mkEnableOption "planet osu-lazer";
      };
    };

  config =
    let
      cfg = config.planet.osu-lazer;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      home.packages = with pkgs; [ osu-lazer-bin ];
      planet.persistence = {
        directories = [ ".local/share/osu" ];
      };
    };
}
