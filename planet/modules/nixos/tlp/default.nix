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
      planet.tlp = {
        enable = mkEnableOption "planet tlp";
        diskDevices = mkOption {
          type = with types; listOf str;
          description = ''
            List of disk devices for TLP to act on.
          '';
        };
        extraSettings = mkOption {
          type =
            with lib.types;
            attrsOf (oneOf [
              bool
              int
              float
              str
              (listOf str)
            ]);
          default = { };
          description = ''
            Extra options passed to TLP to be merged with the default settings.
            See https://linrunner.de/tlp for all supported options.
          '';
        };
      };
    };

  config =
    let
      cfg = config.planet.tlp;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      services.tlp = {
        enable = true;
        settings = {
          START_CHARGE_THRESH_BAT0 = 0;
          STOP_CHARGE_THRESH_BAT0 = 80;
          DISK_DEVICES = lib.strings.concatStringsSep " " cfg.diskDevices;
          DEVICES_TO_DISABLE_ON_LAN_CONNECT = "wifi";
          DEVICES_TO_ENABLE_ON_LAN_DISCONNECT = "wifi";
          DEVICES_TO_DISABLE_ON_BAT_NOT_IN_USE = "bluetooth";
          DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth wwan";
        } // cfg.extraSettings;
      };
    };
}
