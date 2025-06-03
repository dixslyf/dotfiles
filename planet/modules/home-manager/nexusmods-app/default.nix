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
      planet.nexusmods-app = {
        enable = mkEnableOption "planet NexusMods App";
      };
    };

  config =
    let
      cfg = config.planet.nexusmods-app;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      home.packages = with pkgs; [
        nexusmods-app-unfree
      ];

      planet.persistence = {
        directories = [
          ".local/share/NexusMods.App"
        ];
      };
    };
}
