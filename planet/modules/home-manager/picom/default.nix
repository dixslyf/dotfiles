{ config
, lib
, ...
}: {
  options =
    let
      inherit (lib) mkEnableOption mkOption types;
    in
    {
      planet.picom = {
        enable = mkEnableOption "planet picom";
        systemd.target = mkOption {
          type = types.str;
          default = "graphical-session.target";
          description = "The systemd target that will automatically start the picom service.";
        };
      };
    };

  config =
    let
      cfg = config.planet.picom;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      services.picom = {
        enable = true;
        backend = "glx";
        shadow = true;
        shadowExclude = [
          "_GTK_FRAME_EXTENTS@:c"
        ];
        fade = true;
        fadeDelta = 5;
        inactiveOpacity = 0.75;
        settings = {
          blur = {
            method = "dual_kawase";
            size = 24;
            strength = 12;
            deviation = 5.0;
            background-exclude = [
              "window_type = 'dock'"
              "window_type = 'desktop'"
              "_GTK_FRAME_EXTENTS@:c"
            ];
          };
          corner-radius = 8;
          rounded-corners-exclude = [
            "window_type = 'dock'"
            "window_type = 'desktop'"
          ];
          use-ewmh-active-win = true;
          unredir-if-possible = true;
        };
      };

      systemd.user.services.picom = {
        Unit.After = lib.mkForce [ cfg.systemd.target ];
        Unit.PartOf = lib.mkForce [ cfg.systemd.target ];
        Install.WantedBy = lib.mkForce [ cfg.systemd.target ];
      };
    };
}
