{ self' }:
{ config
, lib
, pkgs
, ...
}:
{
  # Disable home-manager's wlsunset module
  disabledModules = [ "services/wlsunset.nix" ];

  options =
    let
      inherit (lib) mkEnableOption mkOption types;
    in
    {
      planet.wlsunset = {
        enable = mkEnableOption "wlsunset";

        package = mkOption {
          type = types.package;
          default = self'.packages.wlsunset;
          defaultText = "self'.packages.wlsunset";
          description = ''
            wlsunset derivation to use.
          '';
        };

        latitude = mkOption {
          type = with types; nullOr (either str float);
          default = null;
          description = ''
            Your current latitude, between <literal>-90.0</literal> and
            <literal>90.0</literal>.
          '';
        };

        longitude = mkOption {
          type = with types; nullOr (either str float);
          default = null;
          description = ''
            Your current longitude, between <literal>-180.0</literal> and
            <literal>180.0</literal>.
          '';
        };

        sunrise = mkOption {
          type = with types; nullOr str;
          default = "07:00";
          example = "06:30";
          description = ''
            Set the time of sunrise manually in <literal>HH:MM</literal> (24-hour clock) format.
          '';
        };

        sunset = mkOption {
          type = with types; nullOr str;
          default = "19:00";
          example = "18:30";
          description = ''
            Set the time of sunset manually in <literal>HH:MM</literal> (24-hour clock) format.
          '';
        };

        duration = mkOption {
          type = with types; nullOr int;
          default = 60;
          example = 1800;
          description = ''
            Set the duration of the transition time in seconds.
            Only applicable in manual time mode i.e. when sunset and/or sunrise are set manually.
          '';
        };

        temperature = {
          day = mkOption {
            type = types.int;
            default = 6500;
            description = ''
              Colour temperature to use during the day, in Kelvin (K).
              This value must be greater than <literal>temperature.night</literal>.
            '';
          };

          night = mkOption {
            type = types.int;
            default = 3400;
            description = ''
              Colour temperature to use during the night, in Kelvin (K).
              This value must be smaller than <literal>temperature.day</literal>.
            '';
          };
        };

        gamma = mkOption {
          type = with types; either str float;
          default = "1.0";
          description = ''
            Gamma value to use.
          '';
        };

        systemd.target = mkOption {
          type = types.str;
          default = "graphical-session.target";
          description = ''
            Systemd target to bind to.
          '';
        };
      };
    };

  config =
    let
      cfg = config.planet.wlsunset;
      inherit (lib) mkIf optionals escapeShellArgs;
    in
    mkIf cfg.enable (
      let
        manual = cfg.sunrise != null || cfg.sunset != null;
        coords = cfg.latitude != null || cfg.longitude != null;
      in
      {
        assertions = [
          (lib.hm.assertions.assertPlatform "services.wlsunset" pkgs
            lib.platforms.linux)
          {
            assertion = !manual || !coords;
            message = ''
              services.wlsunset.latitude and services.wlsunset.longitude cannot be set when services.wlsunset.sunrise and services.wlsunset.sunset are set.
            '';
          }
        ];

        systemd.user.services.wlsunset = {
          Unit = {
            Description = "Day/night gamma adjustments for Wayland compositors.";
            PartOf = [ "graphical-session.target" ];
          };

          Service = {
            ExecStart =
              let
                args =
                  [
                    "-t"
                    (toString cfg.temperature.night)
                    "-T"
                    (toString cfg.temperature.day)
                    "-g"
                    (toString cfg.gamma)
                  ]
                  ++ optionals manual [
                    "-S"
                    (toString cfg.sunrise)
                    "-s"
                    (toString cfg.sunset)
                    "-d"
                    (toString cfg.duration)
                  ]
                  ++ optionals coords [
                    "-l"
                    (toString cfg.latitude)
                    "-L"
                    (toString cfg.longitude)
                  ];
              in
              "${cfg.package}/bin/wlsunset ${escapeShellArgs args}";
          };

          Install = { WantedBy = [ cfg.systemd.target ]; };
        };
      }
    );
}
