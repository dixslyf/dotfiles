{ localFlake', ... }:
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
        localFlake'.packages.cambridge
      ];

      planet.persistence = {
        directories = [
          ".local/share/love/cambridge"
        ];
      };
    };
}
