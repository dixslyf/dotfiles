{ config
, lib
, ...
}: {
  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.earlyoom = {
        enable = mkEnableOption "planet earlyoom";
      };
    };

  config =
    let
      cfg = config.planet.earlyoom;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      services.earlyoom = {
        enable = true;
        freeMemThreshold = 5;
      };
    };
}

