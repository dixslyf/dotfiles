{ config
, lib
, ...
}: {
  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.udiskie = {
        enable = mkEnableOption "planet udiskie";
      };
    };

  config =
    let
      cfg = config.planet.udiskie;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      services.udiskie = {
        enable = true;
        automount = true;
        notify = true;
        tray = "auto";
      };
    };
}

