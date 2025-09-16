{
  config,
  lib,
  pkgs,
  ...
}:
{
  options =
    let
      inherit (lib) mkEnableOption mkOption types;
    in
    {
      planet.zathura = {
        enable = mkEnableOption "planet zathura";
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
      cfg = config.planet.zathura;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      home.packages = [ pkgs.pers-pkgs.iosevka-custom ];
      programs.zathura = {
        enable = true;
        options = {
          font = "Iosevka Custom 16";
          recolor = "true";
          selection-clipboard = "clipboard";
        };
        extraConfig = ''
          include ${pkgs.pers-pkgs.catppuccin-zathura}/share/zathura/themes/catppuccin-macchiato
        '';
      };
      xdg.mimeApps.defaultApplications = mkIf cfg.defaultApplication.enable (
        lib.genAttrs cfg.defaultApplication.mimeTypes (_: "org.pwmt.zathura.desktop")
      );
    };
}
