{
  config,
  lib,
  ...
}:
{
  options =
    let
      inherit (lib)
        mkEnableOption
        ;
    in
    {
      planet.colima = {
        enable = mkEnableOption "planet colima";
      };
    };

  config =
    let
      cfg = config.planet.colima;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      services.colima = {
        enable = true;
        profiles = {
          default = {
            isActive = true;
            isService = true;
          };
        };
      };
    };
}
