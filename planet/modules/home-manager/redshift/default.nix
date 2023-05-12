{ config
, lib
, ...
}: {
  options =
    let
      inherit (lib) mkEnableOption mkOption types;
    in
    {
      planet.redshift = {
        enable = mkEnableOption "planet redshift";
        systemd.target = mkOption {
          type = types.str;
          default = "graphical-session.target";
          description = "The systemd target that will automatically start the flameshot service.";
        };
      };
    };

  config =
    let
      cfg = config.planet.redshift;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      services.redshift = {
        enable = true;
        dawnTime = "07:00";
        duskTime = "19:00";
      };

      systemd.user.services.redshift = {
        Unit.After = lib.mkForce [ cfg.systemd.target ];
        Unit.PartOf = lib.mkForce [ cfg.systemd.target ];
        Install.WantedBy = lib.mkForce [ cfg.systemd.target ];
      };
    };
}
