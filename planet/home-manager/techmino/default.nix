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
      planet.techmino = {
        enable = mkEnableOption "planet techmino";
      };
    };

  config =
    let
      cfg = config.planet.techmino;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      home.packages = with pkgs; [ techmino ];
      planet.persistence = {
        directories = [
          ".local/share/Techmino"
          ".local/share/love/Techmino"
        ];
      };
    };
}
