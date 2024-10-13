{
  config,
  lib,
  ...
}:
{
  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.qt = {
        enable = mkEnableOption "planet qt";
      };
    };

  config =
    let
      cfg = config.planet.qt;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      qt = {
        enable = true;
        platformTheme.name = "gtk3";
      };
    };
}
