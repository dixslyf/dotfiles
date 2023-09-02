{ localFlake', ... }:
{ config
, lib
, ...
}: {
  options =
    let
      inherit (lib) mkEnableOption mkOption types;
    in
    {
      planet.sessions = {
        bspwm = {
          enable = mkEnableOption "planet bspwm session";
          package = mkOption {
            type = types.package;
            default = localFlake'.packages.bspwm;
            description = ''
              bspwm package to use.
            '';
          };
        };
      };
    };

  config =
    let
      cfg = config.planet.sessions;
      inherit (lib) mkMerge mkIf;
    in
    mkMerge [
      (mkIf cfg.bspwm.enable {
        environment.systemPackages = [ cfg.bspwm.package ];
        systemd.user = {
          targets.bspwm-session = {
            bindsTo = [ "graphical-session.target" ];
            partOf = [ "bspwm.service" ];
            unitConfig = {
              RefuseManualStart = true;
              RefuseManualStop = true;
              StopWhenUnneeded = true;
            };
          };
          services.bspwm = {
            description = "bspwm";
            bindsTo = [ "bspwm-session.target" ];
            before = [ "bspwm-session.target" ];
            after = [ "graphical-session-pre.target" ];
            environment = {
              "_JAVA_AWT_WM_NONREPARENTING" = "1";
            };
            serviceConfig = {
              Type = "exec";
              ExecStart = "${cfg.bspwm.package}/bin/bspwm";
            };
          };
        };
        services.xserver.windowManager.session = [{
          name = "bspwm";
          start = ''
            systemctl start --user --wait bspwm.service &
            waitPID=$!
          '';
        }];
      })
    ];
}

