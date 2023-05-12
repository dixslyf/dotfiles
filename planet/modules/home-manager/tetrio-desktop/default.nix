{ config
, lib
, pkgs
, ...
}: {
  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.tetrio-desktop = {
        enable = mkEnableOption "planet tetrio-desktop";
      };
    };

  config =
    let
      cfg = config.planet.tetrio-desktop;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      home.packages = with pkgs; [ (tetrio-desktop.override { withTetrioPlus = true; }) ];
      planet.persistence = {
        directories = [ ".config/tetrio-desktop" ];
      };
    };
}
