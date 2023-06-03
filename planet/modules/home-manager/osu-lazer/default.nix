{ localFlakeInputs', ... }:
{ config
, lib
, ...
}: {
  options =
    let
      inherit (lib) mkEnableOption mkOption types;
    in
    {
      planet.osu-lazer = {
        enable = mkEnableOption "planet osu-lazer";
        defaultApplication = {
          enable = mkEnableOption "MIME default application configuration";
          mimeTypes = mkOption {
            type = types.listOf types.str;
            default = [
              "application/x-osu-skin-archive"
              "application/x-osu-replay"
              "application/x-osu-beatmap-archive"
              "x-scheme-handler/osu"
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
      cfg = config.planet.osu-lazer;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      home.packages = [ localFlakeInputs'.nix-gaming.packages.osu-lazer-bin ];
      planet.persistence = {
        directories = [ ".local/share/osu" ];
      };
      xdg.mimeApps.defaultApplications = mkIf cfg.defaultApplication.enable (
        lib.genAttrs cfg.defaultApplication.mimeTypes (_: "osu-lazer-bin.desktop")
      );
    };
}
