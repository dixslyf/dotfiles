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
      planet.feh = {
        enable = mkEnableOption "planet feh";
        defaultApplication = {
          enable = mkEnableOption "MIME default application configuration";
          mimeTypes = mkOption {
            type = types.listOf types.str;
            default = [
              "image/bmp"
              "image/gif"
              "image/jpeg"
              "image/jpg"
              "image/pjpeg"
              "image/png"
              "image/tiff"
              "image/webp"
              "image/x-bmp"
              "image/x-pcx"
              "image/x-png"
              "image/x-portable-anymap"
              "image/x-portable-bitmap"
              "image/x-portable-graymap"
              "image/x-portable-pixmap"
              "image/x-tga"
              "image/x-xbitmap"
              "image/heic"
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
      cfg = config.planet.feh;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      programs.feh.enable = true;
      xdg.mimeApps.defaultApplications = mkIf cfg.defaultApplication.enable (
        lib.genAttrs cfg.defaultApplication.mimeTypes (_: "feh.desktop")
      );
    };
}
