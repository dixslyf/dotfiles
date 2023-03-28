{ config
, lib
, ...
}: {
  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.fstrim = {
        enable = mkEnableOption "planet fstrim";
      };
    };

  config =
    let
      cfg = config.planet.fstrim;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      services.fstrim.enable = true;
    };
}

