{ config
, lib
, ...
}: {
  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.tealdeer = {
        enable = mkEnableOption "planet tealdeer";
      };
    };

  config =
    let
      cfg = config.planet.tealdeer;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      programs.tealdeer = {
        enable = true;
        settings = {
          display = {
            use_pager = true;
            compact = true;
          };
          updates = {
            auto_update = true;
            auto_update_interval_hours = 168;
          };
        };
      };

      planet.persistence = {
        directories = [ ".cache/tealdeer" ];
      };
    };
}
