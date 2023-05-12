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
      planet.discord = {
        enable = mkEnableOption "planet discord";
      };
    };

  config =
    let
      cfg = config.planet.discord;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      home.packages = with pkgs; [ discord ];
      planet.persistence = {
        directories = [ ".config/discord" ];
      };
    };
}
