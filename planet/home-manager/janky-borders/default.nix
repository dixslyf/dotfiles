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
      planet.janky-borders = {
        enable = mkEnableOption "planet JankyBorders";
      };
    };

  config =
    let
      cfg = config.planet.janky-borders;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      services.jankyborders = {
        enable = true;
        settings = {
          style = "round";
          width = 2.0;
          hidpi = "on";
          active_color = "0xffc6a0f6";
          inactive_color = "0xff8aadf4";
          order = "above";
        };
      };
    };
}
