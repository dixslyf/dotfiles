{ localFlake', ... }:
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
          name = "Catppuccin-Macchiato-Standard-Mauve-dark";
        };
        iconTheme = {
          package = localFlake'.packages.catppuccin-papirus-icon-theme.override {
            color = "cat-macchiato-mauve";
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
