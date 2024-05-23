{ config
, pkgs
, lib
, ...
}: {
  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.dev-man-pages = {
        enable = mkEnableOption "planet dev-man-pages";
      };
    };

  config =
    let
      cfg = config.planet.dev-man-pages;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      home.packages = with pkgs; [
        man-pages
        man-pages-posix
      ];
    };
}
