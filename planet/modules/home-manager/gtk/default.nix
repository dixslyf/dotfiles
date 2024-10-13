{ localFlake', ... }:
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
      planet.gtk = {
        enable = mkEnableOption "planet gtk";
      };
    };

  config =
    let
      cfg = config.planet.gtk;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      home.packages = [ localFlake'.packages.mali ];

      gtk = {
        enable = true;
        font = {
          name = "Mali";
          size = 14;
        };
        theme = {
          package = pkgs.catppuccin-gtk.override {
            accents = [ "mauve" ];
            variant = "macchiato";
            tweaks = [ "rimless" ];
          };
          name = "catppuccin-macchiato-mauve-standard+rimless";
        };
        iconTheme = {
          package = pkgs.catppuccin-papirus-folders.override {
            accent = "mauve";
            flavor = "macchiato";
          };
          name = "Papirus-Dark";
        };
        gtk3.bookmarks = builtins.map (dir: "file://" + config.home.homeDirectory + "/" + dir) [
          "Documents"
          "Downloads"
          "Music"
          "Pictures"
          "Videos"
        ];
      };
    };
}
