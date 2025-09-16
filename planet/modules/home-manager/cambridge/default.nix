{
  config,
  lib,
  pkgs,
  ...
}:
{
  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.cambridge = {
        enable = mkEnableOption "planet cambridge";
      };
    };

  config =
    let
      cfg = config.planet.cambridge;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      home.packages = [
        pkgs.pers-pkgs.cambridge
      ];

      planet.persistence = {
        directories = [
          ".local/share/love/cambridge"
        ];
      };
    };
}
