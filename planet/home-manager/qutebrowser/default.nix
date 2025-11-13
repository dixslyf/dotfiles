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
      planet.qutebrowser = {
        enable = mkEnableOption "planet qutebrowser";
        defaultApplication = {
          enable = mkEnableOption "MIME default application configuration";
          mimeTypes = mkOption {
            type = types.listOf types.str;
            default = [
              "text/html"
              "application/xhtml+xml"
              "x-scheme-handler/http"
              "x-scheme-handler/https"
            ];
            description = ''
              MIME types to be the default application for.
            '';
          };
        };
      };
    };

  config =
    let
      cfg = config.planet.qutebrowser;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      programs.qutebrowser = {
        enable = true;
        extraConfig = ''
          config.set('content.javascript.clipboard', 'access-paste', 'github.com')
        '';
      };

      planet.persistence = {
        directories = [ ".local/share/qutebrowser" ];
      };

      xdg.mimeApps.defaultApplications = mkIf cfg.defaultApplication.enable (
        lib.genAttrs cfg.defaultApplication.mimeTypes (_: "org.qutebrowser.qutebrowser.desktop")
      );
    };
}
