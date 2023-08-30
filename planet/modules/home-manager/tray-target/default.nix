{ config
, lib
, ...
}: {
  options =
    let
      inherit (lib) mkOption types;
    in
    {
      planet.tray-target = {
        enable = mkOption {
          internal = true;
          default = false;
          example = true;
          description = "Whether to enable `tray.target` systemd user target";
          type = types.bool;
        };
      };
    };

  config =
    let
      cfg = config.planet.tray-target;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      systemd.user.targets.tray = {
        Unit = {
          Description = "Home Manager System Tray";
          Requires = [ "graphical-session-pre.target" ];
        };
      };
    };
}
