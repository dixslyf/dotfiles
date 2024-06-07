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
      planet.pointer-cursor = {
        enable = mkEnableOption "planet pointer cursor";
      };
    };

  config =
    let
      cfg = config.planet.pointer-cursor;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      home.pointerCursor = {
        name = "catppuccin-macchiato-dark-cursors";
        package = pkgs.catppuccin-cursors.macchiatoDark;
        x11.enable = true;
        gtk.enable = true;
        size = 32;
      };
    };
}
