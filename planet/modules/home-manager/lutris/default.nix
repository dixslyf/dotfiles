{ config
, lib
, pkgs
, ...
}: {
  options =
    let
      inherit (lib) mkEnableOption mkOption types;
    in
    {
      planet.lutris = {
        enable = mkEnableOption "planet lutris";
        defaultApplication = {
          enable = mkEnableOption "MIME default application configuration";
          mimeTypes = mkOption {
            type = types.listOf types.str;
            default = [ "x-scheme-handler/lutris" ];
            description = ''
              MIME types to be the default application for.
            '';
          };
        };
      };
    };

  config =
    let
      cfg = config.planet.lutris;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      home.packages = with pkgs; [
        lutris
        wineWowPackages.full
      ];
      planet.persistence = {
        directories = [
          ".config/lutris"
          ".local/share/lutris"
        ];
      };
      xdg.mimeApps.defaultApplications = mkIf cfg.defaultApplication.enable (
        lib.genAttrs cfg.defaultApplication.mimeTypes (_: "net.lutris.Lutris.desktop")
      );
    };
}
