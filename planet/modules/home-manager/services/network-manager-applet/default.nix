{ config
, lib
, ...
}: {
  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.network-manager-applet = {
        enable = mkEnableOption "planet network-manager-applet";
      };
    };

  config =
    let
      cfg = config.planet.network-manager-applet;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      services.network-manager-applet.enable = true;
    };
}
