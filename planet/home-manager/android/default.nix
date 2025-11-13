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
      planet.android = {
        enable = mkEnableOption "planet android";
      };
    };

  config =
    let
      cfg = config.planet.android;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      planet.persistence = {
        directories = [
          ".gradle"
          ".android"
          ".cache/Google"
          ".config/Google"
        ];
      };
    };
}
