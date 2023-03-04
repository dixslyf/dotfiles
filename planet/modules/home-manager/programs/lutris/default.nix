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
      planet.lutris = {
        enable = mkEnableOption "planet lutris";
      };
    };

  config =
    let
      cfg = config.planet.lutris;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      home.packages = with pkgs; [ lutris ];
      planet.persistence = {
        directories = [
          ".config/lutris"
          ".local/share/lutris"
        ];
      };
    };
}
