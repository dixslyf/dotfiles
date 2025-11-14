{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.planet.mullvad-vpn;
  jsonFormat = pkgs.formats.json { };
in
{
  options =
    let
      inherit (lib)
        mkEnableOption
        mkOption
        types
        literalExpression
        ;
    in
    {
      planet.mullvad-vpn = {
        enable = mkEnableOption "planet Mullvad VPN";

        package = mkOption {
          type = types.package;
          default = pkgs.mullvad-vpn;
          defaultText = literalExpression "pkgs.mullvad-vpn";
          description = ''
            The Mullvad VPN package to use.
          '';
        };

        settings = mkOption {
          default = { };
          type = types.submodule {
            freeformType = jsonFormat.type;

            options = {
              preferredLocale = mkOption {
                type = types.str;
                default = "system";
                description = ''
                  The locale of the user interface.
                  Use <code>system</code> to opt in for the active
                  locale set in the operating system.
                '';
              };

              autoConnect = mkOption {
                type = types.bool;
                default = false;
                description = ''
                  Enables automatically connecting to a server when the application launches.
                '';
              };

              enableSystemNotifications = mkOption {
                type = types.bool;
                default = true;
                description = ''
                  Enables system notifications.
                  Critical notifications are always displayed regardless of this option.
                '';
              };

              monochromaticIcon = mkOption {
                type = types.bool;
                default = false;
                description = ''
                  Enables the use of a monochromatic tray icon instead of a colored one.
                '';
              };

              startMinimized = mkOption {
                type = types.bool;
                default = false;
                description = ''
                  Show only the tray icon when the application starts.
                '';
              };

              unpinnedWindow = mkOption {
                type = types.bool;
                default = true;
                description = ''
                  If <code>true</code>, the application acts as a normal window.
                  If <code>false</code>, the application acts as a context menu.
                '';
              };

              browsedForSplitTunnelingApplications = mkOption {
                type = types.listOf types.str;
                default = [ ];
                description = ''
                  A list of filepaths to applications added to the list of applications in the split tunneling view.
                '';
              };

              changelogDisplayedForVersion = mkOption {
                type = types.str;
                default = cfg.package.version;
                description = ''
                  The last version that the changelog dialog was shown for.
                  This is used to only show the changelog after an update.
                '';
              };
            };
          };
        };

        systemd = {
          enable = mkEnableOption "systemd integration";
          target = mkOption {
            type = types.str;
            default = "graphical-session.target";
            description = "The systemd target that will automatically start the Mullvad VPN service.";
          };
        };
      };
    };

  config =
    let
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      home.packages = [ cfg.package ];

      xdg.configFile."Mullvad VPN/gui_settings.json" = {
        source = jsonFormat.generate "gui_settings.json" cfg.settings;
      };

      systemd.user.services.mullvad-vpn = mkIf cfg.systemd.enable {
        Unit = {
          Description = "Mullvad VPN GUI";
          After = [
            "graphical-session-pre.target"
            "tray.target"
          ];
          PartOf = [ "graphical-session.target" ];
        };
        Install = {
          WantedBy = [ cfg.systemd.target ];
        };
        Service = {
          ExecStart = "${cfg.package}/bin/mullvad-vpn";
          ExecReload = "${pkgs.coreutils}/bin/kill -HUP $MAINPID";
        };
      };
    };
}
