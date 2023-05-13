{ self' }:
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
      home.packages = [ self'.packages.mali ];

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
          name = "Catppuccin-Macchiato-Standard-Mauve-Dark";
        };
        iconTheme = {
          package = self'.packages.catppuccin-papirus-icon-theme.override {
            color = "cat-macchiato-mauve";
          };
          name = "Papirus-Dark";
        };
      };
    };
}
