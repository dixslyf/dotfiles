{ config
, lib
, ...
}: {
  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.upower = {
        enable = mkEnableOption "planet upower";
      };
    };

  config =
    let
      cfg = config.planet.upower;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      services.upower = {
        enable = true;
        percentageLow = 30;
        percentageCritical = 15;
        percentageAction = 10;
      };
    };
}
