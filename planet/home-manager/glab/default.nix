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
      planet.glab = {
        enable = mkEnableOption "planet glab";
      };
    };

  config =
    let
      cfg = config.planet.glab;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      home.packages = with pkgs; [ glab ];
    };
}
