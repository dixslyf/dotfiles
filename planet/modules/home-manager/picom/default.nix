{ config
, pkgs
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
        package = mkOption {
          type = lib.types.package;
          default = pkgs.picom;
          defaultText = lib.literalExpression "pkgs.picom";
          description = ''
            Picom package to use.
          '';
        };
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
      home.packages = with pkgs; [
        picom
      ];

      xdg.configFile."picom/picom.conf".source = ./picom.conf;

      systemd.user.services.picom = {
        Unit = {
          Description = "Picom X11 compositor";
          After = [ cfg.systemd.target ];
          PartOf = [ cfg.systemd.target ];
        };

        Install = { WantedBy = [ cfg.systemd.target ]; };

        Service = {
          ExecStart = lib.concatStringsSep " " [
            "${lib.getExe cfg.package}"
            "--config ${config.xdg.configFile."picom/picom.conf".source}"
          ];
        };
      };
    };
}
