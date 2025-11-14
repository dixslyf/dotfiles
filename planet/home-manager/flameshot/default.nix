{
  config,
  lib,
  ...
}:
{
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
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
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
        # The original configuration lists `tray.target` as a requirement,
        # so force the Unit configuration to remove it.
        Unit = {
          Requires = lib.mkForce [ ];
          After = lib.mkForce [ cfg.systemd.target ];

          PartOf = lib.mkForce [ cfg.systemd.target ];
        };
        Install.WantedBy = lib.mkForce [ cfg.systemd.target ];
      };
    };
}
