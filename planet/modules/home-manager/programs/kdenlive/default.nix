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
      planet.kdenlive = {
        enable = mkEnableOption "planet kdenlive";
      };
    };

  config =
    let
      cfg = config.planet.kdenlive;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      home.packages = with pkgs; [
        kdenlive
        mediainfo
      ];
    };
}

