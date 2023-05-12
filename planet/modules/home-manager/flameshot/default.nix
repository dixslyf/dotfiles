{ config
, lib
, ...
}: {
  options =
    let
      inherit (lib) mkEnableOption mkOption types;
    in
    {
      planet.flameshot = {
        enable = mkEnableOption "planet flameshot";
        systemd = {
          target = mkOption {
            type = types.str;
            default = "graphical-session.target";
            description = "The systemd target that will automatically start the flameshot service.";
          };
        };
      };
    };

  config =
    let
      cfg = config.planet.flameshot;
    in
    {
      services.flameshot = {
        enable = true;
        settings = {
          General = {
            disabledTrayIcon = true;
            showStartupLaunchMessage = false;
          };
        };
      };

      systemd.user.services.flameshot = {
        # the original configuration lists `tray.target` as a requirement,
        # which the below removes
        Unit.Requires = lib.mkForce [ ];
        Unit.After = lib.mkForce [ cfg.systemd.target ];

        Unit.PartOf = lib.mkForce [ cfg.systemd.target ];
        Install.WantedBy = lib.mkForce [ cfg.systemd.target ];
      };
    };
}
