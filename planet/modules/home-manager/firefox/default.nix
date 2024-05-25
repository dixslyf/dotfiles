{ config
, lib
, ...
}: {
  options =
    let
      inherit (lib) mkEnableOption mkOption types;
    in
    {
      planet.firefox = {
        enable = mkEnableOption "planet firefox";
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
      cfg = config.planet.firefox;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      programs.firefox = {
        enable = true;
        profiles.default = {
          settings = {
            # Hardware video acceleration
            "gfx.webrender.all" = true;
            "media.ffmpeg.vaapi.enabled" = true;
          };
        };
      };

      planet.persistence = {
        directories = [ ".mozilla" ];
      };

      xdg.mimeApps.defaultApplications = mkIf cfg.defaultApplication.enable (
        lib.genAttrs cfg.defaultApplication.mimeTypes (_: "firefox.desktop")
      );
    };
}
