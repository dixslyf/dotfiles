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
      planet.sioyek = {
        enable = mkEnableOption "planet sioyek";
        defaultApplication = {
          enable = mkEnableOption "MIME default application configuration";
          mimeTypes = mkOption {
            type = types.listOf types.str;
            default = [
              "application/pdf"
              "application/oxps"
              "application/epub+zip"
              "application/x-fictionbook"
              "image/vnd.djvu"
              "image/vnd.djvu+multipage"
              "application/postscript"
              "application/eps"
              "application/x-eps"
              "image/eps"
              "image/x-eps"
              "application/x-cbr"
              "application/x-cbz"
              "application/x-cb7"
              "application/x-cbt"
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
      cfg = config.planet.sioyek;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      home.packages = [ localFlake'.packages.iosevka-custom ];
      programs.sioyek = {
        enable = true;
        bindings = {
          screen_up = "<C-u>";
          screen_down = "<C-d>";
          next_page = "J";
          previous_page = "K";
        };
        config = {
          ui_font = "Iosevka Custom";
          font_size = "16";
          page_separator_width = "8";
          should_launch_new_window = "1";
        };
      };

      xdg.mimeApps.defaultApplications = mkIf cfg.defaultApplication.enable (
        lib.genAttrs cfg.defaultApplication.mimeTypes (_: "sioyek.desktop")
      );
    };
}
