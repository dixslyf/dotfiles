{ config
, lib
, ...
}: {
  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.firefox = {
        enable = mkEnableOption "planet firefox";
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
    };
}
