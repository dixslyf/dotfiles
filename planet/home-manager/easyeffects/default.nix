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
      planet.easyeffects = {
        enable = mkEnableOption "planet easyeffects";
      };
    };

  config =
    let
      cfg = config.planet.easyeffects;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      services.easyeffects = {
        enable = true;
      };

      planet.persistence = {
        directories = [
          ".config/easyeffects"
          ".local/share/easyeffects"
        ];
      };
    };
}
