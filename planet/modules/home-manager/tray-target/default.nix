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
        providers = mkOption {
          internal = true;
          default = [ ];
          description = "List of systemd units which provide a system tray";
          type = with types; listOf str;
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
          Description = "System tray";
          PartOf = cfg.providers;
          Before = cfg.providers;
          RefuseManualStart = true;
          RefuseManualStop = true;
          StopWhenUnneeded = true;
        };
        Install = {
          UpheldBy = cfg.providers;
        };
      };
    };
}
