{ config
, lib
, ...
}: {
  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.blueman-applet = {
        enable = mkEnableOption "planet blueman-applet";
      };
    };

  config =
    let
      cfg = config.planet.blueman-applet;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      services.blueman-applet.enable = true;
    };
}
