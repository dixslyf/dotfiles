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
      planet.qmk = {
        enable = mkEnableOption "planet qmk";
      };
    };

  config =
    let
      cfg = config.planet.qmk;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      home.packages = with pkgs; [
        qmk
        via
      ];

      planet.persistence = {
        directories = [
          ".config/qmk"
        ];
      };
    };
}
