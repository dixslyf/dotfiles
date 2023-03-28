{ config
, lib
, ...
}: {
  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.autorandr = {
        enable = mkEnableOption "planet autorandr";
      };
    };

  config =
    let
      cfg = config.planet.autorandr;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      services.autorandr.enable = true;
    };
}

